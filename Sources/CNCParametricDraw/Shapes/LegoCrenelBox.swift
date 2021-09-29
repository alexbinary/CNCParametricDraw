
import Foundation



struct LegoCrenelBox: PathsLayoutRepresentable {
    
    
    let legoUnitLength: MetricLength
    
    let width: LegoLength
    let length: LegoLength
    let height: LegoLength
    
    let crenelConfigInternal: CrenelConfig
    let crenelConfigExternal: CrenelConfig
    
    var numberOfCrenelsWidth: NumerOfCrenelsEnum = .auto
    var numberOfCrenelsLength: NumerOfCrenelsEnum = .auto
    var numberOfCrenelsHeight: NumerOfCrenelsEnum = .auto
    
    
    var pathsLayout: PathsLayout {
        
        let box = CrenelBox(
            
            width: width.resolveToMetric(using: legoUnitLength),
            length: length.resolveToMetric(using: legoUnitLength),
            height: height.resolveToMetric(using: legoUnitLength),
            
            widthCrenelConfig: BoxCrenelConfig(crenelConfigInternal: crenelConfigInternal, crenelConfigExternal: crenelConfigExternal, numberOfCrenels: numberOfCrenelsWidth),
            lengthCrenelConfig: BoxCrenelConfig(crenelConfigInternal: crenelConfigInternal, crenelConfigExternal: crenelConfigExternal, numberOfCrenels: numberOfCrenelsLength),
            heightCrenelConfig: BoxCrenelConfig(crenelConfigInternal: crenelConfigInternal, crenelConfigExternal: crenelConfigExternal, numberOfCrenels: numberOfCrenelsHeight)
        )
        
        return box.pathsLayout
    }
}
