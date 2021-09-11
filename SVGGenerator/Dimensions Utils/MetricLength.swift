
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

