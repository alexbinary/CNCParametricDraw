
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
    
    
    /// Tests that the `.optimized` property removes a `.moveTo` command when it moves to relative (0,0), which is a noop.
    ///
    func test_optimized_move() {
        
        let path = SvgPath(withCommands: [
            .moveTo(Coordinates(x: 0, y: 0), .absolute),
            .moveTo(Coordinates(x: 0, y: 0), .relative),
            .moveTo(Coordinates(x: 1, y: 2), .absolute),
            .moveTo(Coordinates(x: 1, y: 2), .relative),
        ])
        
        XCTAssertEqual(path.optimized.commands, [
            .moveTo(Coordinates(x: 0, y: 0), .absolute),
            .moveTo(Coordinates(x: 1, y: 2), .absolute),
            .moveTo(Coordinates(x: 1, y: 2), .relative),
        ])
    }
    
    
    /// Tests that the `.optimized` property converts `.lineTo` commands to the proper `.axis` command when one of its coordinates is zero, or removes it when it moves to relative (0,0)
    ///
    func test_optimized_line() {
        
        let path = SvgPath(withCommands: [
            .lineTo(Coordinates(x: 0, y: 0), .absolute),
            .lineTo(Coordinates(x: 0, y: 0), .relative),
            .lineTo(Coordinates(x: 0, y: 2), .absolute),
            .lineTo(Coordinates(x: 0, y: 2), .relative),
            .lineTo(Coordinates(x: 1, y: 0), .absolute),
            .lineTo(Coordinates(x: 1, y: 0), .relative),
            .lineTo(Coordinates(x: 1, y: 2), .absolute),
            .lineTo(Coordinates(x: 1, y: 2), .relative),
        ])
        
        XCTAssertEqual(path.optimized.commands, [
            .lineTo(Coordinates(x: 0, y: 0), .absolute),
            .axis(.vertical, 2, .absolute),
            .axis(.vertical, 2, .relative),
            .axis(.horizontal, 1, .absolute),
            .axis(.horizontal, 1, .relative),
            .lineTo(Coordinates(x: 1, y: 2), .absolute),
            .lineTo(Coordinates(x: 1, y: 2), .relative),
        ])
    }
}
