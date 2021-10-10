
import Foundation



struct Cabinet: PathsLayoutRepresentable {
    
    
    let width: MetricLength
    let depth: MetricLength
    
    let shelveHeights: [MetricLength]
    
    let crenelConfigInternal: CrenelConfig
    let crenelConfigExternal: CrenelConfig
    
    let materialThickness: MetricLength
    
    
    var pathsLayout: PathsLayout {
        
        let totalHeight = shelveHeights.reduce(0.mm, { $0 + $1 }) + Float(shelveHeights.count + 1) * materialThickness
        
        var punchLinesPositionsY: [MetricLength] = shelveHeights.map { $0 + 2 * crenelConfigInternal.depth/2 }
        punchLinesPositionsY[0] += crenelConfigInternal.depth/2
        
        let leftRightFace = BoxFace(
            
            width: depth,
            height: totalHeight,
            
            leftCrenelConfig: nil,
            rightCrenelConfig: nil,
            topCrenelConfig: BoxFaceCrenelConfig(
                crenelConfig: crenelConfigInternal,
                numberOfCrenels: .auto,
                direction: .internal
            ),
            bottomCrenelConfig: BoxFaceCrenelConfig(
                crenelConfig: crenelConfigInternal,
                numberOfCrenels: .auto,
                direction: .internal
            ),
            
            punchLinesPositionsY: punchLinesPositionsY,
            punchLinesCrenelConfig: crenelConfigInternal
        )
        
        let topBottomShelveFace = BoxFace(
            
            width: depth,
            height: width,
            
            leftCrenelConfig: nil,
            rightCrenelConfig: nil,
            topCrenelConfig: BoxFaceCrenelConfig(
                crenelConfig: crenelConfigExternal,
                numberOfCrenels: .auto,
                direction: .external
            ),
            bottomCrenelConfig: BoxFaceCrenelConfig(
                crenelConfig: crenelConfigExternal,
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
            for i in 1...(shelveHeights.count - 1) {
                paths.append(topBottomShelveFace.path(withName: "shelve_\(i)"))
            }
        }
        
        return PathsLayout(withVerticallyAlignedPaths: paths)
    }
}
