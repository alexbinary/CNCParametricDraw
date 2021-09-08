
import XCTest

@testable import SVGGenerator



class SizeTest: XCTestCase {


    func test_init_width_height() {

        let size = Size(width: 1, height: 2)
        
        XCTAssertEqual(size.width, 1)
        XCTAssertEqual(size.height, 2)
    }
    
    
    func test_init_points() {

        let size = Size(from: Coordinates(x: 1, y: 2), to: Coordinates(x: 3, y: 4))
        
        XCTAssertEqual(size.width, 2)
        XCTAssertEqual(size.height, 2)
    }
    
    
    func test_equatable() {

        let s1 = Size(width: 1, height: 2)
        let s2 = Size(width: 1, height: 2)
        
        XCTAssertEqual(s1, s2)
        XCTAssertTrue(s1 == s2)
    }
    
    
    func test_zero() {

        let zero = Size.zero
        
        XCTAssertEqual(zero, Size(width: 0, height: 0))
    }
}
