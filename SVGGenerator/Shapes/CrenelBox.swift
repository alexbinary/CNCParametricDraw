
import Foundation



struct CrenelBox: PathsLayoutRepresentable {
    
    
    var width: MetricLength
    var length: MetricLength
    var height: MetricLength
    
    var widthCrenelConfig: BoxCrenelConfig
    var lengthCrenelConfig: BoxCrenelConfig
    var heightCrenelConfig: BoxCrenelConfig
    
    
    var pathsLayout: PathsLayout {
        
        let bottomFace = BoxFace(
            
            width: length,
            height: width,
            
            leftCrenelConfig: BoxFaceCrenelConfig(
                crenelConfig: widthCrenelConfig.crenelConfigInternal,
                numberOfCrenels: widthCrenelConfig.numberOfCrenels,
                direction: .internal
            ),
            rightCrenelConfig: BoxFaceCrenelConfig(
                crenelConfig: widthCrenelConfig.crenelConfigInternal,
                numberOfCrenels: widthCrenelConfig.numberOfCrenels,
                direction: .internal
            ),
            topCrenelConfig: BoxFaceCrenelConfig(
                crenelConfig: lengthCrenelConfig.crenelConfigInternal,
                numberOfCrenels: lengthCrenelConfig.numberOfCrenels,
                direction: .internal
            ),
            bottomCrenelConfig: BoxFaceCrenelConfig(
                crenelConfig: lengthCrenelConfig.crenelConfigInternal,
                numberOfCrenels: lengthCrenelConfig.numberOfCrenels,
                direction: .internal
            )
        )
        
        let frontBackFace = BoxFace(
            
            width: length,
            height: height,
            
            leftCrenelConfig: BoxFaceCrenelConfig(
                crenelConfig: heightCrenelConfig.crenelConfigInternal,
                numberOfCrenels: heightCrenelConfig.numberOfCrenels,
                direction: .internal
            ),
            rightCrenelConfig: BoxFaceCrenelConfig(
                crenelConfig: heightCrenelConfig.crenelConfigExternal,
                numberOfCrenels: heightCrenelConfig.numberOfCrenels,
                direction: .external
            ),
            topCrenelConfig: nil,
            bottomCrenelConfig: BoxFaceCrenelConfig(
                crenelConfig: lengthCrenelConfig.crenelConfigExternal,
                numberOfCrenels: lengthCrenelConfig.numberOfCrenels,
                direction: .external
            )
        )
        
        let leftRightFace = BoxFace(
            
            width: width,
            height: height,
            
            leftCrenelConfig: BoxFaceCrenelConfig(
                crenelConfig: heightCrenelConfig.crenelConfigInternal,
                numberOfCrenels: heightCrenelConfig.numberOfCrenels,
                direction: .internal
            ),
            rightCrenelConfig: BoxFaceCrenelConfig(
                crenelConfig: heightCrenelConfig.crenelConfigExternal,
                numberOfCrenels: heightCrenelConfig.numberOfCrenels,
                direction: .external
            ),
            topCrenelConfig: nil,
            bottomCrenelConfig: BoxFaceCrenelConfig(
                crenelConfig: widthCrenelConfig.crenelConfigExternal,
                numberOfCrenels: widthCrenelConfig.numberOfCrenels,
                direction: .external
            )
        )
        
        return PathsLayout(withVerticallyAlignedPaths: [
                            bottomFace.path(withName: "bottom"),
                            frontBackFace.path(withName: "front").transformedMirrorY,
                            frontBackFace.path(withName: "back"),
                            leftRightFace.path(withName: "left").transformedMirrorY,
                            leftRightFace.path(withName: "right"),
        ])
    }
}
