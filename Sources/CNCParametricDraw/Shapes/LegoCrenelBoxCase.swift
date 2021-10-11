
import Foundation



struct LegoCrenelBoxCase: PathsLayoutRepresentable {
    
    
    let legoUnitLength: MetricLength
    
    let materialThickness: MetricLength
    let margin: MetricLength
    
    let width: LegoLength
    let length: LegoLength
    let height: LegoLength
    
    var widthCrenelConfig: BoxCrenelConfig
    var lengthCrenelConfig: BoxCrenelConfig
    var heightCrenelConfig: BoxCrenelConfig
    
    
    var actualWidth: MetricLength { width.resolveToMetric(using: legoUnitLength) + 2 * materialThickness + margin }
    var actualLength: MetricLength { length.resolveToMetric(using: legoUnitLength) + 2 * materialThickness + margin }
    var actualHeight: MetricLength { height.resolveToMetric(using: legoUnitLength) + materialThickness + margin }
    
    
    var pathsLayout: PathsLayout {
        
        let box = CrenelBox(
            
            width: actualWidth,
            length: actualLength,
            height: actualHeight,
            
            widthCrenelConfig: widthCrenelConfig,
            lengthCrenelConfig: lengthCrenelConfig,
            heightCrenelConfig: heightCrenelConfig
        )
        
        return box.pathsLayout
    }
}
