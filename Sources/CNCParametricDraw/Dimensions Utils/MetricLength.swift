
import Foundation



/// A type that stores a length in the metric system.
///
/// To create an instance of this type, use the `init(millimeters:)` initializer, passing the length expressed in millimeters.
///
/// ```swift
/// let length = MetricLength(millimeters: 35)
/// ```
///
/// A more convenient and more readable way is to use the `.mm` extensions available on `Float`, `Double` and `Int`.
///
/// ```swift
/// let length = 35.mm
/// ```
///
/// To get a numeric value from an instance of the `MetricLength` type, use the `.toMillimeters` property.
///
/// ```swift
/// let length = 35.mm
/// print(length.toMillimeters) // 35.0
/// ```
///
public struct MetricLength: Equatable {
    
    private let millimeters: Float
    
    init(millimeters: Float) {
        
        self.millimeters = millimeters
    }
    
    var toMillimeters: Float { self.millimeters }
}


extension Float {
    
    public var mm: MetricLength { MetricLength(millimeters: self) }
}


extension Double {
    
    public var mm: MetricLength { Float(self).mm }
}


extension Int {
    
    public var mm: MetricLength { Float(self).mm }
}


func +(lhs: MetricLength, rhs: MetricLength) -> MetricLength {
    
    return MetricLength(millimeters: lhs.toMillimeters + rhs.toMillimeters)
}


func +=(lhs: inout MetricLength, rhs: MetricLength) {
    
    lhs = lhs + rhs
}


public prefix func -(l: MetricLength) -> MetricLength {
    
    return MetricLength(millimeters: -l.toMillimeters)
}


func -(lhs: MetricLength, rhs: MetricLength) -> MetricLength {
    
    return lhs + (-rhs)
}


func *(lhs: Float, rhs: MetricLength) -> MetricLength {
    
    return MetricLength(millimeters: lhs * rhs.toMillimeters)
}


func *(lhs: Int, rhs: MetricLength) -> MetricLength {
    
    return Float(lhs) * rhs
}


func /(lhs: MetricLength, rhs: Float) -> MetricLength {
    
    return MetricLength(millimeters: lhs.toMillimeters / rhs)
}


public func /(lhs: MetricLength, rhs: Int) -> MetricLength {
    
    return lhs / Float(rhs)
}


func /(lhs: MetricLength, rhs: MetricLength) -> Float {
    
    return lhs.toMillimeters / rhs.toMillimeters
}
