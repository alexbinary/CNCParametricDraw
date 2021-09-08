
import XCTest

@testable import SVGGenerator



class CoordinatesBoxTest: XCTestCase {


    func test_init_origin_size() {

        let box = CoordinatesBox(origin: Coordinates(x: 1, y: 2), size: Size(width: 3, height: 4))
        
        XCTAssertEqual(box.origin, Coordinates(x: 1, y: 2))
        XCTAssertEqual(box.size, Size(width: 3, height: 4))
    }
    
    
    func test_endPoint() {

        let box = CoordinatesBox(origin: Coordinates(x: 1, y: 2), size: Size(width: 3, height: 4))
        
        XCTAssertEqual(box.endPoint, Coordinates(x: 4, y: 6))
    }
    
    
    func test_offsetBy() {

        let box1 = CoordinatesBox(origin: Coordinates(x: 1, y: 2), size: Size(width: 3, height: 4))
        let box2 = box1.offsetBy(Coordinates(x: 5, y: 6))
        
        XCTAssertEqual(box1.origin, Coordinates(x: 1, y: 2))
        XCTAssertEqual(box1.size, Size(width: 3, height: 4))
        
        XCTAssertEqual(box2.origin, Coordinates(x: 6, y: 8))
        XCTAssertEqual(box2.size, Size(width: 3, height: 4))
    }
}
