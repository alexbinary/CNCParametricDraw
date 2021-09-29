
import Foundation



public struct LegoCabinet {
    
    
    let legoUnitLength: MetricLength
    
    let materialThickness: MetricLength
    let margin: MetricLength
    
    
    let width: LegoLength
    let depth: LegoLength
    
    let shelvesHeights: [LegoLength]
    
    let crenelConfig: CrenelConfig
    
    
    public init(
        legoUnitLength: MetricLength,
        materialThickness: MetricLength,
        margin: MetricLength,
        width: LegoLength,
        depth: LegoLength,
        shelvesHeights: [LegoLength],
        crenelConfig: CrenelConfig
    ) {
        self.legoUnitLength = legoUnitLength
        self.materialThickness = materialThickness
        self.margin = margin
        self.width = width
        self.depth = depth
        self.shelvesHeights = shelvesHeights
        self.crenelConfig = crenelConfig
    }
    
    
    public var pathsLayout: PathsLayout {
        
        let boxCase = LegoCrenelBoxCase(
            
            legoUnitLength: legoUnitLength,
            
            materialThickness: materialThickness,
            margin: margin,
            
            width: width,
            length: depth,
            height: 1.plates,
            
            crenelConfigInternal: crenelConfig,
            crenelConfigExternal: crenelConfig
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
                    
                    crenelConfigInternal: crenelConfig,
                    crenelConfigExternal: crenelConfig
                )
                
                return boxCase.actualHeight + margin
                
            },
            
            crenelConfig: crenelConfig,
            materialThickness: materialThickness
        )
        
        return cabinet.pathsLayout
    }
}
