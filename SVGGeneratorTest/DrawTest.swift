
import XCTest

@testable import SVGGenerator



class DrawTest: XCTestCase {


    func test_Path_endPoint_line() {
        
        let path = Path(commands: [
            .lineTo(Coordinates(x: 1, y: 2)),
        ])
        
        XCTAssertEqual(path.endPoint, Coordinate(x: 1, y: 2))
    }
    
    func test_Path_endPoint_move() {
        
        let path = Path(commands: [
            .moveTo(Coordinate(x: 1, y: 2)),
        ])
        
        XCTAssertEqual(path.endPoint, Coordinate(x: 1, y: 2))
    }
    
    func test_Path_endPoint_lineClose() {
        
        let path = Path(commands: [
            .lineTo(Coordinate(x: 1, y: 2)),
            .close,
        ])
        
        XCTAssertEqual(path.endPoint, Coordinate(x: 0, y: 0))
    }
    
    func test_Path_endPoint_lineCloseLine() {
        
        let path = Path(commands: [
            .lineTo(Coordinate(x: 1, y: 2)),
            .close,
            .lineTo(Coordinate(x: 3, y: 4)),
        ])
        
        XCTAssertEqual(path.endPoint, Coordinate(x: 3, y: 4))
    }
    
    func test_Path_endPoint_moveLineClose() {
        
        let path = Path(commands: [
            .moveTo(Coordinate(x: 1, y: 2)),
            .lineTo(Coordinate(x: 3, y: 4)),
            .close,
        ])
        
        XCTAssertEqual(path.endPoint, Coordinate(x: 1, y: 2))
    }
    
    func test_Path_endPoint_moveLineCloseLine() {
        
        let path = Path(commands: [
            .moveTo(Coordinate(x: 1, y: 2)),
            .lineTo(Coordinate(x: 3, y: 4)),
            .close,
            .lineTo(Coordinate(x: 5, y: 6)),
        ])
        
        XCTAssertEqual(path.endPoint, Coordinate(x: 6, y: 8))
    }
    
    func test_Path_endPoint_lineMoveLine() {
        
        let path = Path(commands: [
            .lineTo(Coordinate(x: 1, y: 2)),
            .moveTo(Coordinate(x: 3, y: 4)),
            .lineTo(Coordinate(x: 5, y: 6)),
        ])
        
        XCTAssertEqual(path.endPoint, Coordinate(x: 9, y: 12))
    }
    
    func test_Path_endPoint_lineMoveLineClose() {
        
        let path = Path(commands: [
            .lineTo(Coordinate(x: 1, y: 2)),
            .moveTo(Coordinate(x: 3, y: 4)),
            .lineTo(Coordinate(x: 5, y: 6)),
            .close,
        ])
        
        XCTAssertEqual(path.endPoint, Coordinate(x: 0, y: 0))
    }
    
    func test_Path_endPoint_moveLineMove() {
        
        let path = Path(commands: [
            .moveTo(Coordinate(x: 1, y: 2)),
            .lineTo(Coordinate(x: 3, y: 4)),
            .moveTo(Coordinate(x: 5, y: 6)),
        ])
        
        XCTAssertEqual(path.endPoint, Coordinate(x: 9, y: 12))
    }
    
    func test_Path_endPoint_moveLineMoveClose() {
        
        let path = Path(commands: [
            .moveTo(Coordinate(x: 1, y: 2)),
            .lineTo(Coordinate(x: 3, y: 4)),
            .moveTo(Coordinate(x: 5, y: 6)),
            .close,
        ])
        
        XCTAssertEqual(path.endPoint, Coordinate(x: 1, y: 2))
    }
    
    
    func test_Path_boundingBox_line() {
        
        let path = Path(commands: [
            .lineTo(Coordinate(x: 1, y: 2)),
        ])
        
        XCTAssertEqual(path.boundingBox, Box(origin: Coordinate(x: 0, y: 0), size: Size(width: 1, height: 2)))
    }
    
    func test_Path_boundingBox_line_negative() {
        
        let path = Path(commands: [
            .lineTo(Coordinate(x: -1, y: -2)),
        ])
        
        XCTAssertEqual(path.boundingBox, Box(origin: Coordinate(x: -1, y: -2), size: Size(width: 1, height: 2)))
    }
    
    func test_Path_boundingBox_move() {
        
        let path = Path(commands: [
            .moveTo(Coordinate(x: 1, y: 2)),
        ])
        
        XCTAssertEqual(path.boundingBox, Box(origin: Coordinate(x: 0, y: 0), size: Size(width: 1, height: 2)))
    }
    
    func test_Path_boundingBox_move_nagative() {
        
        let path = Path(commands: [
            .moveTo(Coordinate(x: -1, y: -2)),
        ])
        
        XCTAssertEqual(path.boundingBox, Box(origin: Coordinate(x: -1, y: -2), size: Size(width: 1, height: 2)))
    }
    
    func test_Path_boundingBox_lineMoveLine() {
        
        let path = Path(commands: [
            .lineTo(Coordinate(x: 1, y: 2)),
            .moveTo(Coordinate(x: 3, y: 4)),
            .lineTo(Coordinate(x: -5, y: -6)),
        ])
        
        XCTAssertEqual(path.boundingBox, Box(origin: Coordinate(x: -1, y: 0), size: Size(width: 5, height: 6)))
    }
}
