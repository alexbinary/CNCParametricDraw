
import Foundation



struct MetricLength {
    
    private let millimeters: Float
    
    init(millimeters: Float) {
        
        self.millimeters = millimeters
    }
    
    var toMillimeters: Float { self.millimeters }
}


extension Float {
    
    var mm: MetricLength { MetricLength(millimeters: self) }
}


extension Int {
    
    var mm: MetricLength { Float(self).mm }
}


func +(lhs: MetricLength, rhs: MetricLength) -> MetricLength {
    
    return MetricLength(millimeters: lhs.toMillimeters + rhs.toMillimeters)
}


func +=(lhs: inout MetricLength, rhs: MetricLength) {
    
    lhs = lhs + rhs
}


prefix func -(l: MetricLength) -> MetricLength {
    
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


func /(lhs: MetricLength, rhs: Int) -> MetricLength {
    
    return lhs / Float(rhs)
}


func /(lhs: MetricLength, rhs: MetricLength) -> Float {
    
    return lhs.toMillimeters / rhs.toMillimeters
}
