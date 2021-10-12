
import XCTest

@testable import CNCParametricDraw



/// Tests for the `SvgPath` type.
///
class SvgPathTest: XCTestCase {


    /// Tests that the `.optimized` property does not change a `.close` command.
    ///
    func test_optimized_close() {
        
        let path = SvgPath(withCommands: [
            .close,
        ])
        
        XCTAssertEqual(path.optimized.commands, [
            .close,
        ])
    }
    
    
    /// Tests that the `.optimized` property does not change an `.axis` command.
    ///
    func test_optimized_axis() {
        
        let path = SvgPath(withCommands: [
            .axis(.horizontal, 1, .absolute),
            .axis(.horizontal, 2, .relative),
            .axis(.vertical, 3, .absolute),
            .axis(.vertical, 4, .relative),
        ])
        
        XCTAssertEqual(path.optimized.commands, [
            .axis(.horizontal, 1, .absolute),
            .axis(.horizontal, 2, .relative),
            .axis(.vertical, 3, .absolute),
            .axis(.vertical, 4, .relative),
        ])
    }
    
    
    /// Tests that the `.optimized` property does not change a `.moveTo` command whose target is not `(0,0)`
    ///
    func test_optimized_moveTo_nonZero() {
        
        let path = SvgPath(withCommands: [
            .moveTo(Coordinates(x: 1, y: 2), .absolute),
            .moveTo(Coordinates(x: 1, y: 2), .relative),
        ])
        
        XCTAssertEqual(path.optimized.commands, [
            .moveTo(Coordinates(x: 1, y: 2), .absolute),
            .moveTo(Coordinates(x: 1, y: 2), .relative),
        ])
    }
    
    
    /// Tests that the `.optimized` property removes a `.moveTo` command whose target is `(0,0)` when its type is `.relative`.
    ///
    func test_optimized_moveTo_relativeZeroZero() {
        
        let path = SvgPath(withCommands: [
            .moveTo(Coordinates(x: 0, y: 0), .relative),
        ])
        
        XCTAssertEqual(path.optimized.commands, [
        ])
    }
    
    
    /// Tests that the `.optimized` property does not remove a `.moveTo` command whose target is `(0,0)` when its type is `.absolute`.
    ///
    func test_optimized_moveTo_absoluteZeroZero() {
        
        let path = SvgPath(withCommands: [
            .moveTo(Coordinates(x: 0, y: 0), .absolute),
        ])
        
        XCTAssertEqual(path.optimized.commands, [
            .moveTo(Coordinates(x: 0, y: 0), .absolute),
        ])
    }
    
    
    /// Tests that the `.optimized` property does not change a `.lineTo` command with non-zero coordinates.
    ///
    func test_optimized_lineTo_nonZero() {
        
        let path = SvgPath(withCommands: [
            .lineTo(Coordinates(x: 1, y: 2), .absolute),
            .lineTo(Coordinates(x: 1, y: 2), .relative),
        ])
        
        XCTAssertEqual(path.optimized.commands, [
            .lineTo(Coordinates(x: 1, y: 2), .absolute),
            .lineTo(Coordinates(x: 1, y: 2), .relative),
        ])
    }
    
    
    /// Tests that the `.optimized` property removes a `.lineTo` command whose target is `(0,0)` when its type is `.relative`.
    ///
    func test_optimized_lineTo_relativeZeroZero() {
        
        let path = SvgPath(withCommands: [
            .lineTo(Coordinates(x: 0, y: 0), .relative),
        ])
        
        XCTAssertEqual(path.optimized.commands, [
        ])
    }
    
    
    /// Tests that the `.optimized` property does not remove a `.lineTo` command whose target is `(0,0)` when its type is `.absolute`.
    ///
    func test_optimized_lineTo_absoluteZeroZero() {
        
        let path = SvgPath(withCommands: [
            .lineTo(Coordinates(x: 0, y: 0), .absolute),
        ])
        
        XCTAssertEqual(path.optimized.commands, [
            .axis(.vertical, 0, .absolute),
        ])
    }
    
    
    /// Tests that the `.optimized` property converts `.lineTo` commands to `.axis` commands of type `.horizontal`  when the `.y` coordinate is zero.
    ///
    func test_optimized_lineTo_yZero() {
        
        let path = SvgPath(withCommands: [
            .lineTo(Coordinates(x: 1, y: 0), .absolute),
            .lineTo(Coordinates(x: 1, y: 0), .relative),
        ])
        
        XCTAssertEqual(path.optimized.commands, [
            .axis(.horizontal, 1, .absolute),
            .axis(.horizontal, 1, .relative),
        ])
    }
    
    
    /// Tests that the `.optimized` property converts `.lineTo` commands to `.axis` commands of type `.vertical`  when the `.x` coordinate is zero.
    ///
    func test_optimized_lineTo_xZero() {
        
        let path = SvgPath(withCommands: [
            .lineTo(Coordinates(x: 0, y: 2), .absolute),
            .lineTo(Coordinates(x: 0, y: 2), .relative),
        ])
        
        XCTAssertEqual(path.optimized.commands, [
            .axis(.vertical, 2, .absolute),
            .axis(.vertical, 2, .relative),
        ])
    }
}
