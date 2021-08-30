
import Foundation



enum BoxCrenelDirection {
    
    
    case external
    case `internal`
}



struct BoxCrenelConfig {

    
    var direction: BoxCrenelDirection
    var crenelConfig: CrenelConfig
    var numberOfCrenels: UInt
}



struct BoxFaceSize: Equatable {

    
    var width: Float
    var height: Float
}



class BoxFace: Path {
        
    
    init(
        size: BoxFaceSize,
        leftCrenelConfig: BoxCrenelConfig?,
        rightCrenelConfig: BoxCrenelConfig?,
        topCrenelConfig: BoxCrenelConfig?,
        bottomCrenelConfig: BoxCrenelConfig?
    ) {
         
        let totalPath: Path = .empty
        
        let offsetLeft = leftCrenelConfig != nil && leftCrenelConfig!.direction == .external ? leftCrenelConfig!.crenelConfig.depth : 0
        let offsetRight = rightCrenelConfig != nil && rightCrenelConfig!.direction == .external ? rightCrenelConfig!.crenelConfig.depth : 0
        
        let offsetTop = topCrenelConfig != nil && topCrenelConfig!.direction == .external ? topCrenelConfig!.crenelConfig.depth : 0
        let offsetBottom = bottomCrenelConfig != nil && bottomCrenelConfig!.direction == .external ? bottomCrenelConfig!.crenelConfig.depth : 0
        
        totalPath.append(.moveToRelative(Coordinates(x: offsetLeft, y: offsetTop)))
        
        let horizontalLength = size.width - offsetLeft - offsetRight
        let verticalLength = size.height - offsetTop - offsetBottom
        
        if let crenelConfig = leftCrenelConfig {
            
            let crenelPath = CrenelPath(
                totalLength: size.height,
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
                totalLength: size.width,
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
                totalLength: size.height,
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
                totalLength: size.width,
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



struct BoxSize: Equatable {

    
    var width: Float
    var height: Float
    var length: Float
}



//class Box: Path {
//    
//    
//    init(
//        size: Size,
//        leftCrenelConfig: BoxCrenelConfig?,
//        rightCrenelConfig: BoxCrenelConfig?,
//        topCrenelConfig: BoxCrenelConfig?,
//        bottomCrenelConfig: BoxCrenelConfig?
//    ) {
//    }
//}
