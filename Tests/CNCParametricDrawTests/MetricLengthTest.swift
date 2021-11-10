
import XCTest

@testable import CNCParametricDraw



class MetricLengthTest: XCTestCase {


    func test_init_millimeters() {

        let length = MetricLength(millimeters: 35)
        
        XCTAssertEqual(length.toMillimeters, 35)
    }
    
    
    func test_toMillimeters() {

        let length = MetricLength(millimeters: 35)
        
        XCTAssertEqual(length.toMillimeters, 35)
    }
    
    
    func test_extension_float_mm() {

        let length = Float(35).mm
        
        XCTAssertEqual(length.toMillimeters, 35)
    }
    
    
    func test_extension_double_mm() {

        let length = Double(35).mm
        
        XCTAssertEqual(length.toMillimeters, 35)
    }
    
    
    func test_extension_Int_mm() {

        let length = Int(35).mm
        
        XCTAssertEqual(length.toMillimeters, 35)
    }
    
    
    func test_operator_plus() {

        XCTAssertEqual(35.mm + 7.mm, 42.mm)
    }
    
    
    func test_operator_plusEqual() {

        var length = 35.mm
        length += 7.mm
        
        XCTAssertEqual(length, 42.mm)
    }
    
    
    func test_operator_prefix_minus() {

        XCTAssertEqual(-(35.mm), (-35).mm)
    }
    
    
    func test_operator_minus() {

        XCTAssertEqual(35.mm - 7.mm, 28.mm)
    }
    
    
    func test_operator_times_float() {

        XCTAssertEqual(Float(2)*(35.mm), 70.mm)
    }
    
    
    func test_operator_times_int() {

        XCTAssertEqual(Int(2)*(35.mm), 70.mm)
    }
    
    
    func test_operator_dividedBy() {

        XCTAssertEqual((70.mm)/(35.mm), Float(2))
    }
    
    
    func test_operator_dividedBy_float() {

        XCTAssertEqual((70.mm)/Float(2), 35.mm)
    }
    
    
    func test_operator_dividedBy_int() {

        XCTAssertEqual((70.mm)/Int(2), 35.mm)
    }
}
