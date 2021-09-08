
import XCTest

@testable import SVGGenerator



class RectTest: XCTestCase {


    func test_init_origin_size() {

        let rect = Rect(origin: Point(x: 1, y: 2), size: Size(width: 3, height: 4))
        
        XCTAssertEqual(rect.origin, Point(x: 1, y: 2))
        XCTAssertEqual(rect.size, Size(width: 3, height: 4))
    }
    
    
    func test_endPoint() {

        let rect = Rect(origin: Point(x: 1, y: 2), size: Size(width: 3, height: 4))
        
        XCTAssertEqual(rect.endPoint, Point(x: 4, y: 6))
    }
    
    
    func test_offsetBy() {

        let rect1 = Rect(origin: Point(x: 1, y: 2), size: Size(width: 3, height: 4))
        let rect2 = rect1.offsetBy(Offset(x: 5, y: 6))
        
        XCTAssertEqual(rect1.origin, Point(x: 1, y: 2))
        XCTAssertEqual(rect1.size, Size(width: 3, height: 4))
        
        XCTAssertEqual(rect2.origin, Point(x: 6, y: 8))
        XCTAssertEqual(rect2.size, Size(width: 3, height: 4))
    }
}
