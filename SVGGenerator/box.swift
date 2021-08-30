
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



struct BoxFace: Path {
        
    
    let size: Size
    
    let leftCrenelConfig: BoxCrenelConfig?
    let rightCrenelConfig: BoxCrenelConfig?
    let topCrenelConfig: BoxCrenelConfig?
    let bottomCrenelConfig: BoxCrenelConfig?
    
    
    var commands: [PathCommand] {
        
        var commands: [PathCommand] = []
        
        let offsetLeft = leftCrenelConfig != nil && leftCrenelConfig!.direction == .external ? leftCrenelConfig!.crenelConfig.depth : 0
        let offsetRight = rightCrenelConfig != nil && rightCrenelConfig!.direction == .external ? rightCrenelConfig!.crenelConfig.depth : 0
        
        let offsetTop = topCrenelConfig != nil && topCrenelConfig!.direction == .external ? topCrenelConfig!.crenelConfig.depth : 0
        let offsetBottom = bottomCrenelConfig != nil && bottomCrenelConfig!.direction == .external ? bottomCrenelConfig!.crenelConfig.depth : 0
        
        commands.append(.moveToRelative(Coordinates(x: offsetLeft, y: offsetTop)))
        
        let horizontalLength = size.width - offsetLeft - offsetRight
        let verticalLength = size.height - offsetTop - offsetBottom
        
        if let crenelConfig = leftCrenelConfig {
            
            var path = CrenelPath(
                totalLength: size.height,
                numberOfCrenels: crenelConfig.numberOfCrenels,
                crenelConfig: crenelConfig.crenelConfig,
                offsetStart: offsetTop,
                offsetEnd: -offsetBottom
            ).rotated90DegreesClockWise
            
            if crenelConfig.direction == .internal {
                path = path.mirrorX
            }
            
            commands.append(contentsOf:path.commands)
        } else {
            commands.append(.lineToRelative(Coordinates(x: 0, y: verticalLength)))
        }
        
        if let crenelConfig = bottomCrenelConfig {
            
            var path: Path = CrenelPath(
                totalLength: size.width,
                numberOfCrenels: crenelConfig.numberOfCrenels,
                crenelConfig: crenelConfig.crenelConfig,
                offsetStart: offsetLeft,
                offsetEnd: -offsetRight
            )
            
            if crenelConfig.direction == .internal {
                path = path.mirrorY
            }
            
            commands.append(contentsOf: path.commands)
        } else {
            commands.append(.lineToRelative(Coordinates(x: horizontalLength, y: 0)))
        }
        
        if let crenelConfig = rightCrenelConfig {
            
            var path = CrenelPath(
                totalLength: size.height,
                numberOfCrenels: crenelConfig.numberOfCrenels,
                crenelConfig: crenelConfig.crenelConfig,
                offsetStart: offsetBottom,
                offsetEnd: -offsetTop
            ).rotated270DegreesClockWise
            
            if crenelConfig.direction == .internal {
                path = path.mirrorX
            }
            
            commands.append(contentsOf:path.commands)
        } else {
            commands.append(.lineToRelative(Coordinates(x: 0, y: verticalLength)))
        }
        
        if let crenelConfig = topCrenelConfig {
            
            var path: Path = CrenelPath(
                totalLength: size.width,
                numberOfCrenels: crenelConfig.numberOfCrenels,
                crenelConfig: crenelConfig.crenelConfig,
                offsetStart: offsetRight,
                offsetEnd: -offsetLeft
            ).rotated180DegreesClockWise
            
            if crenelConfig.direction == .internal {
                path = path.mirrorY
            }
            
            commands.append(contentsOf: path.commands)
        } else {
            commands.append(.lineToRelative(Coordinates(x: -horizontalLength, y: 0)))
        }
        
        return commands
    }
}
