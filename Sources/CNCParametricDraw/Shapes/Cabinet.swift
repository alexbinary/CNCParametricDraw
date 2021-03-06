
import Foundation



struct Cabinet: PathsLayoutRepresentable {
    
    
    let width: MetricLength
    let depth: MetricLength
    
    let shelveHeights: [MetricLength]
    
    let crenelConfig: CrenelConfig
    
    let materialThickness: MetricLength
    
    
    var pathsLayout: PathsLayout {
        
        let totalHeight = shelveHeights.reduce(0.mm, { $0 + $1 }) + Float(shelveHeights.count + 1) * materialThickness
        
        var punchLinesPositionsY: [MetricLength] = shelveHeights.map { $0 + 2 * crenelConfig.depth/2 }
        punchLinesPositionsY[0] += crenelConfig.depth/2
        
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
            
            punchLinesPositionsY: punchLinesPositionsY,
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
            for i in 1...(shelveHeights.count - 1) {
                paths.append(topBottomShelveFace.path(withName: "shelve_\(i)"))
            }
        }
        
        return PathsLayout(withVerticallyAlignedPaths: paths)
    }
}
