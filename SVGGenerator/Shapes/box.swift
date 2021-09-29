
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



struct LegoCrenelBoxCase: PathsLayoutRepresentable {
    
    
    let legoUnitLength: MetricLength
    
    let materialThickness: MetricLength
    let margin: MetricLength
    
    let width: LegoLength
    let length: LegoLength
    let height: LegoLength
    
    let crenelConfigInternal: CrenelConfig
    let crenelConfigExternal: CrenelConfig
    
    let numberOfCrenelsWidth: NumerOfCrenelsEnum = .auto
    let numberOfCrenelsLength: NumerOfCrenelsEnum = .auto
    let numberOfCrenelsHeight: NumerOfCrenelsEnum = .auto
    
    
    var actualWidth: MetricLength { width.resolveToMetric(using: legoUnitLength) + 2 * materialThickness + margin }
    var actualLength: MetricLength { length.resolveToMetric(using: legoUnitLength) + 2 * materialThickness + margin }
    var actualHeight: MetricLength { height.resolveToMetric(using: legoUnitLength) + materialThickness + margin }
    
    
    var pathsLayout: PathsLayout {
        
        let box = CrenelBox(
            
            width: actualWidth,
            length: actualLength,
            height: actualHeight,
            
            widthCrenelConfig: BoxCrenelConfig(crenelConfigInternal: crenelConfigInternal, crenelConfigExternal: crenelConfigExternal, numberOfCrenels: numberOfCrenelsWidth),
            lengthCrenelConfig: BoxCrenelConfig(crenelConfigInternal: crenelConfigInternal, crenelConfigExternal: crenelConfigExternal, numberOfCrenels: numberOfCrenelsLength),
            heightCrenelConfig: BoxCrenelConfig(crenelConfigInternal: crenelConfigInternal, crenelConfigExternal: crenelConfigExternal, numberOfCrenels: numberOfCrenelsHeight)
        )
        
        return box.pathsLayout
    }
}
