
import Foundation



enum BoxCrenelDirection {
    
    
    case external
    case `internal`
}



struct BoxFaceCrenelConfig {

    
    var crenelConfig: CrenelConfig
    var numberOfCrenels: UInt
    var direction: BoxCrenelDirection
}



class BoxFace: Path {
        
    
    init(
        width boxWidth: Float,
        height boxHeight: Float,
        leftCrenelConfig: BoxFaceCrenelConfig?,
        rightCrenelConfig: BoxFaceCrenelConfig?,
        topCrenelConfig: BoxFaceCrenelConfig?,
        bottomCrenelConfig: BoxFaceCrenelConfig?
    ) {
         
        let totalPath: Path = .empty
        
        let offsetLeft = leftCrenelConfig != nil && leftCrenelConfig!.direction == .external ? leftCrenelConfig!.crenelConfig.depth : 0
        let offsetRight = rightCrenelConfig != nil && rightCrenelConfig!.direction == .external ? rightCrenelConfig!.crenelConfig.depth : 0
        
        let offsetTop = topCrenelConfig != nil && topCrenelConfig!.direction == .external ? topCrenelConfig!.crenelConfig.depth : 0
        let offsetBottom = bottomCrenelConfig != nil && bottomCrenelConfig!.direction == .external ? bottomCrenelConfig!.crenelConfig.depth : 0
        
        totalPath.append(.moveToRelative(Coordinates(x: offsetLeft, y: offsetTop)))
        
        let horizontalLength = boxWidth - offsetLeft - offsetRight
        let verticalLength = boxHeight - offsetTop - offsetBottom
        
        if let crenelConfig = leftCrenelConfig {
            
            let crenelPath = CrenelPath(
                totalLength: boxHeight,
                numberOfCrenels: crenelConfig.numberOfCrenels,
                crenelConfig: crenelConfig.crenelConfig,
                offsetStart: offsetTop,
                offsetEnd: -offsetBottom
            ).rotated90DegreesClockWise
            
            if crenelConfig.direction == .internal {
                crenelPath.mirrorX()
            }
            
            totalPath.append(crenelPath)
        } else {
            totalPath.append(.lineToRelative(Coordinates(x: 0, y: verticalLength)))
        }
        
        if let crenelConfig = bottomCrenelConfig {
            
            let crenelPath: Path = CrenelPath(
                totalLength: boxWidth,
                numberOfCrenels: crenelConfig.numberOfCrenels,
                crenelConfig: crenelConfig.crenelConfig,
                offsetStart: offsetLeft,
                offsetEnd: -offsetRight
            )
            
            if crenelConfig.direction == .internal {
                crenelPath.mirrorY()
            }
            
            totalPath.append(crenelPath)
        } else {
            totalPath.append(.lineToRelative(Coordinates(x: horizontalLength, y: 0)))
        }
        
        if let crenelConfig = rightCrenelConfig {
            
            let crenelPath = CrenelPath(
                totalLength: boxHeight,
                numberOfCrenels: crenelConfig.numberOfCrenels,
                crenelConfig: crenelConfig.crenelConfig,
                offsetStart: offsetBottom,
                offsetEnd: -offsetTop
            ).rotated270DegreesClockWise
            
            if crenelConfig.direction == .internal {
                crenelPath.mirrorX()
            }
            
            totalPath.append(crenelPath)
        } else {
            totalPath.append(.lineToRelative(Coordinates(x: 0, y: verticalLength)))
        }
        
        if let crenelConfig = topCrenelConfig {
            
            let crenelPath: Path = CrenelPath(
                totalLength: boxWidth,
                numberOfCrenels: crenelConfig.numberOfCrenels,
                crenelConfig: crenelConfig.crenelConfig,
                offsetStart: offsetRight,
                offsetEnd: -offsetLeft
            ).rotated180DegreesClockWise
            
            if crenelConfig.direction == .internal {
                crenelPath.mirrorY()
            }
            
            totalPath.append(crenelPath)
        } else {
            totalPath.append(.lineToRelative(Coordinates(x: -horizontalLength, y: 0)))
        }
        
        super.init(fromPath: totalPath)
    }
}



struct BoxCrenelConfig {

    
    var crenelConfig: CrenelConfig
    var numberOfCrenels: UInt
}



class Box: PathGroup {
    
    
    let bottomFace: Path
    
    let frontFace: Path
    let backFace: Path
    
    let leftFace: Path
    let rightFace: Path
    
    
    init(
        width boxWidth: Float,
        height boxHeight: Float,
        length boxLength: Float,
        widthCrenelConfig: BoxCrenelConfig,
        heightCrenelConfig: BoxCrenelConfig,
        lengthCrenelConfig: BoxCrenelConfig
    ) {
        var paths: [Path] = []
        
        self.bottomFace = BoxFace(
            
            width: boxLength,
            height: boxWidth,
            
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
        
        self.frontFace = BoxFace(
            
            width: boxLength,
            height: boxHeight,
            
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
        
        self.backFace = self.frontFace.copy
        
        self.leftFace = BoxFace(
            
            width: boxWidth,
            height: boxHeight,
            
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
        
        self.rightFace = self.leftFace.copy
        
        paths.append(bottomFace)
        paths.append(frontFace)
        paths.append(backFace)
        paths.append(leftFace)
        paths.append(rightFace)
        
        super.init(withPaths: paths)
    }
}
