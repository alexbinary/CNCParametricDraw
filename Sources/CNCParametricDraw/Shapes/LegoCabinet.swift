
import Foundation



public struct LegoCabinet {
    
    
    let legoUnitLength: MetricLength
    
    let materialThickness: MetricLength
    let margin: MetricLength
    
    
    let width: LegoLength
    let depth: LegoLength
    
    let shelvesHeights: [LegoLength]
    
    let crenelConfigInternal: CrenelConfig
    let crenelConfigExternal: CrenelConfig
    
    
    public init(
        legoUnitLength: MetricLength,
        materialThickness: MetricLength,
        margin: MetricLength,
        width: LegoLength,
        depth: LegoLength,
        shelvesHeights: [LegoLength],
        crenelConfigInternal: CrenelConfig,
        crenelConfigExternal: CrenelConfig
    ) {
        self.legoUnitLength = legoUnitLength
        self.materialThickness = materialThickness
        self.margin = margin
        self.width = width
        self.depth = depth
        self.shelvesHeights = shelvesHeights
        self.crenelConfigInternal = crenelConfigInternal
        self.crenelConfigExternal = crenelConfigExternal
    }
    
    
    public var pathsLayout: PathsLayout {
        
        let boxCase = LegoCrenelBoxCase(
            
            legoUnitLength: legoUnitLength,
            
            materialThickness: materialThickness,
            margin: margin,
            
            width: width,
            length: depth,
            height: 1.plates,
            
            widthCrenelConfig: BoxCrenelConfig(crenelConfigInternal: crenelConfigInternal, crenelConfigExternal: crenelConfigExternal, numberOfCrenels: .auto),
            lengthCrenelConfig: BoxCrenelConfig(crenelConfigInternal: crenelConfigInternal, crenelConfigExternal: crenelConfigExternal, numberOfCrenels: .auto),
            heightCrenelConfig: BoxCrenelConfig(crenelConfigInternal: crenelConfigInternal, crenelConfigExternal: crenelConfigExternal, numberOfCrenels: .auto)
        )
        
        let cabinet = Cabinet(
            
            width: boxCase.actualWidth + margin + 2 * materialThickness,
            depth: boxCase.actualLength,
            shelveHeights: shelvesHeights.map {
                
                let boxCase = LegoCrenelBoxCase(
                    
                    legoUnitLength: legoUnitLength,
                    
                    materialThickness: materialThickness,
                    margin: margin,
                    
                    width: width,
                    length: depth,
                    height: $0,
                    
                    widthCrenelConfig: BoxCrenelConfig(crenelConfigInternal: crenelConfigInternal, crenelConfigExternal: crenelConfigExternal, numberOfCrenels: .auto),
                    lengthCrenelConfig: BoxCrenelConfig(crenelConfigInternal: crenelConfigInternal, crenelConfigExternal: crenelConfigExternal, numberOfCrenels: .auto),
                    heightCrenelConfig: BoxCrenelConfig(crenelConfigInternal: crenelConfigInternal, crenelConfigExternal: crenelConfigExternal, numberOfCrenels: .auto)
                )
                
                return boxCase.actualHeight + margin
                
            },
            
            crenelConfigInternal: crenelConfigInternal,
            crenelConfigExternal: crenelConfigExternal,
            
            materialThickness: materialThickness
        )
        
        return cabinet.pathsLayout
    }
}
