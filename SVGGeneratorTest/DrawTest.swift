
import XCTest

@testable import SVGGenerator



class DrawTest: XCTestCase {


    func test_Coordinate_add() {

        var coordinate = Coordinate(x: 1, y: 2)
        
        let coordinateCopy = coordinate
        
        coordinate.add(Coordinate(x: 3, y: 4))
        
        XCTAssertEqual(coordinate, Coordinate(x: 4, y: 6))
        XCTAssertEqual(coordinateCopy, Coordinate(x: 1, y: 2))
    }
    
    func test_Path_endPoint_line() {
        
        let path = SinglePath(commands: [
            .lineTo(Coordinate(x: 1, y: 2)),
        ])
        
        XCTAssertEqual(path.endPoint, Coordinate(x: 1, y: 2))
    }
    
    func test_Path_endPoint_move() {
        
        let path = SinglePath(commands: [
            .moveTo(Coordinate(x: 1, y: 2)),
        ])
        
        XCTAssertEqual(path.endPoint, Coordinate(x: 1, y: 2))
    }
    
    func test_Path_endPoint_lineClose() {
        
        let path = SinglePath(commands: [
            .lineTo(Coordinate(x: 1, y: 2)),
            .close,
        ])
        
        XCTAssertEqual(path.endPoint, Coordinate(x: 0, y: 0))
    }
    
    func test_Path_endPoint_lineCloseLine() {
        
        let path = SinglePath(commands: [
            .lineTo(Coordinate(x: 1, y: 2)),
            .close,
            .lineTo(Coordinate(x: 3, y: 4)),
        ])
        
        XCTAssertEqual(path.endPoint, Coordinate(x: 3, y: 4))
    }
    
    func test_Path_endPoint_moveLineClose() {
        
        let path = SinglePath(commands: [
            .moveTo(Coordinate(x: 1, y: 2)),
            .lineTo(Coordinate(x: 3, y: 4)),
            .close,
        ])
        
        XCTAssertEqual(path.endPoint, Coordinate(x: 1, y: 2))
    }
    
    func test_Path_endPoint_moveLineCloseLine() {
        
        let path = SinglePath(commands: [
            .moveTo(Coordinate(x: 1, y: 2)),
            .lineTo(Coordinate(x: 3, y: 4)),
            .close,
            .lineTo(Coordinate(x: 5, y: 6)),
        ])
        
        XCTAssertEqual(path.endPoint, Coordinate(x: 6, y: 8))
    }
    
    func test_Path_endPoint_lineMoveLine() {
        
        let path = SinglePath(commands: [
            .lineTo(Coordinate(x: 1, y: 2)),
            .moveTo(Coordinate(x: 3, y: 4)),
            .lineTo(Coordinate(x: 5, y: 6)),
        ])
        
        XCTAssertEqual(path.endPoint, Coordinate(x: 9, y: 12))
    }
    
    func test_Path_endPoint_lineMoveLineClose() {
        
        let path = SinglePath(commands: [
            .lineTo(Coordinate(x: 1, y: 2)),
            .moveTo(Coordinate(x: 3, y: 4)),
            .lineTo(Coordinate(x: 5, y: 6)),
            .close,
        ])
        
        XCTAssertEqual(path.endPoint, Coordinate(x: 0, y: 0))
    }
    
    func test_Path_endPoint_moveLineMove() {
        
        let path = SinglePath(commands: [
            .moveTo(Coordinate(x: 1, y: 2)),
            .lineTo(Coordinate(x: 3, y: 4)),
            .moveTo(Coordinate(x: 5, y: 6)),
        ])
        
        XCTAssertEqual(path.endPoint, Coordinate(x: 9, y: 12))
    }
    
    func test_Path_endPoint_moveLineMoveClose() {
        
        let path = SinglePath(commands: [
            .moveTo(Coordinate(x: 1, y: 2)),
            .lineTo(Coordinate(x: 3, y: 4)),
            .moveTo(Coordinate(x: 5, y: 6)),
            .close,
        ])
        
        XCTAssertEqual(path.endPoint, Coordinate(x: 1, y: 2))
    }
}
