
import XCTest

@testable import CNCParametricDraw



class DrawTest: XCTestCase {


    func test_Path_endPoint_line() {
        
        let path = Path(withCommands: [
            .lineToRelative(Coordinates(x: 1, y: 2)),
        ])
        
        XCTAssertEqual(path.endPoint, Coordinates(x: 1, y: 2))
    }
    
    func test_Path_endPoint_move() {
        
        let path = Path(withCommands: [
            .moveToRelative(Coordinates(x: 1, y: 2)),
        ])
        
        XCTAssertEqual(path.endPoint, Coordinates(x: 1, y: 2))
    }
    
    func test_Path_endPoint_lineClose() {
        
        let path = Path(withCommands: [
            .lineToRelative(Coordinates(x: 1, y: 2)),
            .close,
        ])
        
        XCTAssertEqual(path.endPoint, Coordinates(x: 0, y: 0))
    }
    
    func test_Path_endPoint_lineCloseLine() {
        
        let path = Path(withCommands: [
            .lineToRelative(Coordinates(x: 1, y: 2)),
            .close,
            .lineToRelative(Coordinates(x: 3, y: 4)),
        ])
        
        XCTAssertEqual(path.endPoint, Coordinates(x: 3, y: 4))
    }
    
    func test_Path_endPoint_moveLineClose() {
        
        let path = Path(withCommands: [
            .moveToRelative(Coordinates(x: 1, y: 2)),
            .lineToRelative(Coordinates(x: 3, y: 4)),
            .close,
        ])
        
        XCTAssertEqual(path.endPoint, Coordinates(x: 1, y: 2))
    }
    
    func test_Path_endPoint_moveLineCloseLine() {
        
        let path = Path(withCommands: [
            .moveToRelative(Coordinates(x: 1, y: 2)),
            .lineToRelative(Coordinates(x: 3, y: 4)),
            .close,
            .lineToRelative(Coordinates(x: 5, y: 6)),
        ])
        
        XCTAssertEqual(path.endPoint, Coordinates(x: 6, y: 8))
    }
    
    func test_Path_endPoint_lineMoveLine() {
        
        let path = Path(withCommands: [
            .lineToRelative(Coordinates(x: 1, y: 2)),
            .moveToRelative(Coordinates(x: 3, y: 4)),
            .lineToRelative(Coordinates(x: 5, y: 6)),
        ])
        
        XCTAssertEqual(path.endPoint, Coordinates(x: 9, y: 12))
    }
    
    func test_Path_endPoint_lineMoveLineClose() {
        
        let path = Path(withCommands: [
            .lineToRelative(Coordinates(x: 1, y: 2)),
            .moveToRelative(Coordinates(x: 3, y: 4)),
            .lineToRelative(Coordinates(x: 5, y: 6)),
            .close,
        ])
        
        XCTAssertEqual(path.endPoint, Coordinates(x: 0, y: 0))
    }
    
    func test_Path_endPoint_moveLineMove() {
        
        let path = Path(withCommands: [
            .moveToRelative(Coordinates(x: 1, y: 2)),
            .lineToRelative(Coordinates(x: 3, y: 4)),
            .moveToRelative(Coordinates(x: 5, y: 6)),
        ])
        
        XCTAssertEqual(path.endPoint, Coordinates(x: 9, y: 12))
    }
    
    func test_Path_endPoint_moveLineMoveClose() {
        
        let path = Path(withCommands: [
            .moveToRelative(Coordinates(x: 1, y: 2)),
            .lineToRelative(Coordinates(x: 3, y: 4)),
            .moveToRelative(Coordinates(x: 5, y: 6)),
            .close,
        ])
        
        XCTAssertEqual(path.endPoint, Coordinates(x: 1, y: 2))
    }
    
    
    func test_Path_boundingBox_line() {
        
        let path = Path(withCommands: [
            .lineToRelative(Coordinates(x: 1, y: 2)),
        ])
        
        XCTAssertEqual(path.boundingBox, Rect(origin: Coordinates(x: 0, y: 0), size: Size(width: 1, height: 2)))
    }
    
    func test_Path_boundingBox_line_negative() {
        
        let path = Path(withCommands: [
            .lineToRelative(Coordinates(x: -1, y: -2)),
        ])
        
        XCTAssertEqual(path.boundingBox, Rect(origin: Coordinates(x: -1, y: -2), size: Size(width: 1, height: 2)))
    }
    
    func test_Path_boundingBox_move() {
        
        let path = Path(withCommands: [
            .moveToRelative(Coordinates(x: 1, y: 2)),
        ])
        
        XCTAssertEqual(path.boundingBox, Rect(origin: Coordinates(x: 0, y: 0), size: Size(width: 1, height: 2)))
    }
    
    func test_Path_boundingBox_move_nagative() {
        
        let path = Path(withCommands: [
            .moveToRelative(Coordinates(x: -1, y: -2)),
        ])
        
        XCTAssertEqual(path.boundingBox, Rect(origin: Coordinates(x: -1, y: -2), size: Size(width: 1, height: 2)))
    }
    
    func test_Path_boundingBox_lineMoveLine() {
        
        let path = Path(withCommands: [
            .lineToRelative(Coordinates(x: 1, y: 2)),
            .moveToRelative(Coordinates(x: 3, y: 4)),
            .lineToRelative(Coordinates(x: -5, y: -6)),
        ])
        
        XCTAssertEqual(path.boundingBox, Rect(origin: Coordinates(x: -1, y: 0), size: Size(width: 5, height: 6)))
    }
}
