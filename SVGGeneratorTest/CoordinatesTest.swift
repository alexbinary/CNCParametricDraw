
import XCTest

@testable import SVGGenerator



class CoordinatesTest: XCTestCase {


    func test_Coordinate_add() {

        var coordinate = Coordinate(x: 1, y: 2)
        
        let coordinateCopy = coordinate
        
        coordinate.add(Coordinate(x: 3, y: 4))
        
        XCTAssertEqual(coordinate, Coordinate(x: 4, y: 6))
        XCTAssertEqual(coordinateCopy, Coordinate(x: 1, y: 2))
    }
}
