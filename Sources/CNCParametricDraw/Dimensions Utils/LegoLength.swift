
import Foundation



public struct LegoLength {
    
    let numberOfLegoUnits: Float
    
    static let unitsPerPlate: Float = 1
    static let unitsPerStud: Float = 2.5
    
    init(plates numberOfPlates: Float) {
        
        self.numberOfLegoUnits = numberOfPlates * Self.unitsPerPlate
    }
    
    init(studs numberOfStuds: Float) {
        
        self.numberOfLegoUnits = numberOfStuds * Self.unitsPerStud
    }
    
    func resolveToMetric(using legoUnitDimension: MetricLength) -> MetricLength {
        
        return MetricLength(millimeters: numberOfLegoUnits * legoUnitDimension.toMillimeters)
    }
}


extension Float {
    
    public var plates: LegoLength { LegoLength(plates: self) }
    
    public var studs: LegoLength { LegoLength(studs: self) }
}


extension Int {
    
    public var plates: LegoLength { Float(self).plates }
    
    public var studs: LegoLength { Float(self).studs }
}
