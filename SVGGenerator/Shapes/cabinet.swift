
import Foundation



struct Cabinet: PathsLayoutRepresentable {
    
    
    let width: MetricLength
    let depth: MetricLength
    
    let shelveHeights: [MetricLength]
    
    let crenelConfig: CrenelConfig
    
    let materialThickness: MetricLength
    
    
    var pathsLayout: PathsLayout {
        
        let totalHeight = shelveHeights.reduce(0, { $0 + $1.toMillimeters }) + Float(shelveHeights.count + 1) * materialThickness.toMillimeters
        
        var punchLinesHeights: [MetricLength] = shelveHeights.map { MetricLength(millimeters: $0.toMillimeters + 2 * crenelConfig.depth.toMillimeters/2) }
        punchLinesHeights[0] = MetricLength(millimeters: punchLinesHeights[0].toMillimeters + crenelConfig.depth.toMillimeters/2)
        
        let leftRightFace = BoxFace(
            
            width: depth,
            height: MetricLength(millimeters: totalHeight),
            
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
    
    
    let numberOfStudsWidth: Float
    let numberOfStudsDepth: Float
    
    let shelvesNumberOfPlatesHeightsFromBottomToTop: [Float]
    
    let crenelConfig: CrenelConfig
    
    
    var pathsLayout: PathsLayout {
        
        let cabinet = Cabinet(
            
            width: MetricLength(millimeters: numberOfStudsWidth * legoUnitLength.toMillimeters * 2.5 + 2 * materialThickness.toMillimeters + margin.toMillimeters + margin.toMillimeters + 2 * materialThickness.toMillimeters),
            depth: MetricLength(millimeters: numberOfStudsDepth * legoUnitLength.toMillimeters * 2.5 + 2 * materialThickness.toMillimeters + margin.toMillimeters),
            shelveHeights: shelvesNumberOfPlatesHeightsFromBottomToTop.map { MetricLength(millimeters: $0 * legoUnitLength.toMillimeters + materialThickness.toMillimeters + margin.toMillimeters + margin.toMillimeters) },
            
            crenelConfig: crenelConfig,
            materialThickness: materialThickness
        )
        
        return cabinet.pathsLayout
    }
}
