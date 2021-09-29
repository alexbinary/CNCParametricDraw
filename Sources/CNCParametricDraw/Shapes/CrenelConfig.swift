
import Foundation



public struct CrenelConfig {
    
    
    let baseLength: MetricLength
    let lengthAdjustment: MetricLength
    let depth: MetricLength
    
    
    public init(
        baseLength: MetricLength,
        lengthAdjustment: MetricLength,
        depth: MetricLength
    ) {
        self.baseLength = baseLength
        self.lengthAdjustment = lengthAdjustment
        self.depth = depth
    }
}
