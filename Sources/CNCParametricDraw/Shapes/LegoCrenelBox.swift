
import Foundation



struct LegoCrenelBox: PathsLayoutRepresentable {
    
    
    let legoUnitLength: MetricLength
    
    let width: LegoLength
    let length: LegoLength
    let height: LegoLength
    
    var widthCrenelConfig: BoxCrenelConfig
    var lengthCrenelConfig: BoxCrenelConfig
    var heightCrenelConfig: BoxCrenelConfig
    
    var pathsLayout: PathsLayout {
        
        let box = CrenelBox(
            
            width: width.resolveToMetric(using: legoUnitLength),
            length: length.resolveToMetric(using: legoUnitLength),
            height: height.resolveToMetric(using: legoUnitLength),
            
            widthCrenelConfig: widthCrenelConfig,
            lengthCrenelConfig: lengthCrenelConfig,
            heightCrenelConfig: heightCrenelConfig
        )
        
        return box.pathsLayout
    }
}
