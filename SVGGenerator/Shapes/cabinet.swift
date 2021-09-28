
import Foundation



struct Cabinet: PathsLayoutRepresentable {
    
    
    let width: MetricLength
    let depth: MetricLength
    
    let shelveHeights: [MetricLength]
    
    let crenelConfig: CrenelConfig
    
    let materialThickness: MetricLength
    
    
    var pathsLayout: PathsLayout {
        
        let totalHeight = shelveHeights.reduce(0.mm, { $0 + $1 }) + Float(shelveHeights.count + 1) * materialThickness
        
        var punchLinesHeights: [MetricLength] = shelveHeights.map { $0 + 2 * crenelConfig.depth/2 }
        punchLinesHeights[0] += crenelConfig.depth/2
        
        let leftRightFace = BoxFace(
            
            width: depth,
            height: totalHeight,
            
            leftCrenelConfig: nil,
            rightCrenelConfig: nil,
            topCrenelConfig: BoxFaceCrenelConfig(
                crenelConfig: crenelConfig,
                numberOfCrenels: .auto,
                direction: .internal
            ),
            bottomCrenelConfig: BoxFaceCrenelConfig(
                crenelConfig: crenelConfig,
                numberOfCrenels: .auto,
                direction: .internal
            ),
            
            punchLinesPositionYStartingFromBottom: punchLinesHeights,
            punchLinesCrenelConfig: crenelConfig
        )
        
        let topBottomShelveFace = BoxFace(
            
            width: depth,
            height: width,
            
            leftCrenelConfig: nil,
            rightCrenelConfig: nil,
            topCrenelConfig: BoxFaceCrenelConfig(
                crenelConfig: crenelConfig,
                numberOfCrenels: .auto,
                direction: .external
            ),
            bottomCrenelConfig: BoxFaceCrenelConfig(
                crenelConfig: crenelConfig,
                numberOfCrenels: .auto,
                direction: .external
            )
        )
        
        var paths = [
            leftRightFace.path(withName: "left"),
            leftRightFace.path(withName: "right"),
            topBottomShelveFace.path(withName: "top"),
            topBottomShelveFace.path(withName: "bottom"),
        ]
        
        if shelveHeights.count > 1 {
            for i in 1..<(shelveHeights.count - 1) {
                paths.append(topBottomShelveFace.path(withName: "shelve_\(i)"))
            }
        }
        
        return PathsLayout(withVerticallyAlignedPaths: paths)
    }
}


struct LegoCabinet {
    
    
    let legoUnitLength: MetricLength
    
    let materialThickness: MetricLength
    let margin: MetricLength
    
    
    let width: LegoLength
    let depth: LegoLength
    
    let shelvesHeightsFromBottomToTop: [LegoLength]
    
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
            shelveHeights: shelvesHeightsFromBottomToTop.map {
                
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
