
import Foundation



struct BoxFace: PathProtocol {
        
    let size: Size
    
    let leftCrenelConfig: CrenelConfig?
    let rightCrenelConfig: CrenelConfig?
    let topCrenelConfig: CrenelConfig?
    let bottomCrenelConfig: CrenelConfig?
    
    var commands: [PathCommand] {
        
        var commands: [PathCommand] = []
        
        commands.append(.moveToRelative(Coordinate(x: leftCrenelConfig?.depth ?? 0, y: topCrenelConfig?.depth ?? 0)))
        
        let totalLengthVertical = size.height - (topCrenelConfig?.depth ?? 0) - (bottomCrenelConfig?.depth ?? 0)
        let totalLengthHorizontal = size.width - (leftCrenelConfig?.depth ?? 0) - (rightCrenelConfig?.depth ?? 0)
        
        if let leftCrenelConfig = leftCrenelConfig {
            commands.append(contentsOf:
                                CrenelPath(
                                    totalLength: totalLengthVertical,
                                    numberOfCrenels: 5,
                                    crenelConfig: leftCrenelConfig,
                                    offsetStart: 0,
                                    offsetEnd: 0
                                ).commands
            )
        } else {
            commands.append(.lineToRelative(Coordinate(x: 0, y: totalLengthVertical)))
        }
        
        if let bottomCrenelConfig = bottomCrenelConfig {
            commands.append(contentsOf:
                                CrenelPath(
                                    totalLength: size.width,
                                    numberOfCrenels: 5,
                                    crenelConfig: bottomCrenelConfig,
                                    offsetStart: leftCrenelConfig?.depth ?? 0,
                                    offsetEnd: -(rightCrenelConfig?.depth ?? 0)
                                ).commands
            )
        } else {
            commands.append(.lineToRelative(Coordinate(x: totalLengthHorizontal, y: 0)))
        }
        
        // TODO continue
        
        return commands
    }
}
