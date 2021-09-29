
import Foundation



struct LegoCabinet {
    
    
    let legoUnitLength: MetricLength
    
    let materialThickness: MetricLength
    let margin: MetricLength
    
    
    let width: LegoLength
    let depth: LegoLength
    
    let shelvesHeights: [LegoLength]
    
    let crenelConfig: CrenelConfig
    
    
    var pathsLayout: PathsLayout {
        
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
