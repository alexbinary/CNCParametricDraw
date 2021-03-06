
import Foundation



public struct CrenelBox: PathsLayoutRepresentable {
    
    
    var width: MetricLength
    var length: MetricLength
    var height: MetricLength
    
    var widthCrenelConfig: BoxCrenelConfig
    var lengthCrenelConfig: BoxCrenelConfig
    var heightCrenelConfig: BoxCrenelConfig
    
    
    public init(
        width: MetricLength,
        length: MetricLength,
        height: MetricLength,
        widthCrenelConfig: BoxCrenelConfig,
        lengthCrenelConfig: BoxCrenelConfig,
        heightCrenelConfig: BoxCrenelConfig
    ) {
        self.width = width
        self.length = length
        self.height = height
        self.widthCrenelConfig = widthCrenelConfig
        self.lengthCrenelConfig = lengthCrenelConfig
        self.heightCrenelConfig = heightCrenelConfig
    }
    
    
    public var pathsLayout: PathsLayout {
        
        let bottomFace = BoxFace(
            
            width: length,
            height: width,
            
            leftCrenelConfig: BoxFaceCrenelConfig(
                crenelConfig: widthCrenelConfig.crenelConfig,
                numberOfCrenels: widthCrenelConfig.numberOfCrenels,
                direction: .internal
            ),
            rightCrenelConfig: BoxFaceCrenelConfig(
                crenelConfig: widthCrenelConfig.crenelConfig,
                numberOfCrenels: widthCrenelConfig.numberOfCrenels,
                direction: .internal
            ),
            topCrenelConfig: BoxFaceCrenelConfig(
                crenelConfig: lengthCrenelConfig.crenelConfig,
                numberOfCrenels: lengthCrenelConfig.numberOfCrenels,
                direction: .internal
            ),
            bottomCrenelConfig: BoxFaceCrenelConfig(
                crenelConfig: lengthCrenelConfig.crenelConfig,
                numberOfCrenels: lengthCrenelConfig.numberOfCrenels,
                direction: .internal
            )
        )
        
        let frontBackFace = BoxFace(
            
            width: length,
            height: height,
            
            leftCrenelConfig: BoxFaceCrenelConfig(
                crenelConfig: heightCrenelConfig.crenelConfig,
                numberOfCrenels: heightCrenelConfig.numberOfCrenels,
                direction: .internal
            ),
            rightCrenelConfig: BoxFaceCrenelConfig(
                crenelConfig: heightCrenelConfig.crenelConfig,
                numberOfCrenels: heightCrenelConfig.numberOfCrenels,
                direction: .external
            ),
            topCrenelConfig: nil,
            bottomCrenelConfig: BoxFaceCrenelConfig(
                crenelConfig: lengthCrenelConfig.crenelConfig,
                numberOfCrenels: lengthCrenelConfig.numberOfCrenels,
                direction: .external
            )
        )
        
        let leftRightFace = BoxFace(
            
            width: width,
            height: height,
            
            leftCrenelConfig: BoxFaceCrenelConfig(
                crenelConfig: heightCrenelConfig.crenelConfig,
                numberOfCrenels: heightCrenelConfig.numberOfCrenels,
                direction: .internal
            ),
            rightCrenelConfig: BoxFaceCrenelConfig(
                crenelConfig: heightCrenelConfig.crenelConfig,
                numberOfCrenels: heightCrenelConfig.numberOfCrenels,
                direction: .external
            ),
            topCrenelConfig: nil,
            bottomCrenelConfig: BoxFaceCrenelConfig(
                crenelConfig: widthCrenelConfig.crenelConfig,
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
