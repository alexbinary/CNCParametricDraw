
import Foundation



enum CrenelDirection {
    
    case normal
    case reversed
}

func *(lhs: Float, rhs: CrenelDirection) -> Float {
 
    return lhs * (rhs == .normal ? +1 : -1)
}

struct CrenelConfig {
    
    let baseLength: Float
    let lengthAdjustment: Float
    let depth: Float
}

struct CrenelPath: PathProtocol {
    
    let totalLength: Float
    let numberOfCrenels: UInt
    let crenelConfig: CrenelConfig
    let direction: CrenelDirection
    let offsetStart: Float
    let offsetEnd: Float
    
    var commands: [PathCommand] {
        
        let crenelActualLength: Float = crenelConfig.baseLength + crenelConfig.lengthAdjustment
        let antiCrenelActualLength: Float = crenelConfig.baseLength - crenelConfig.lengthAdjustment
        
        let totalCrenelationLength: Float = Float(numberOfCrenels) * crenelActualLength + max(Float(numberOfCrenels) - 1, 0) * antiCrenelActualLength
        
        let buttsTotalLength: Float = totalLength - totalCrenelationLength
        let buttsStartLength: Float = buttsTotalLength/2
        let buttsEndLength: Float = buttsTotalLength - buttsStartLength

        let buttStartMove: PathCommand = .lineToRelative(Coordinate(x: buttsStartLength - offsetStart, y: 0))
        let crenelMove: [PathCommand] = [
            .lineToRelative(Coordinate(x: 0, y: crenelConfig.depth * direction)),
            .lineToRelative(Coordinate(x: crenelActualLength, y: 0)),
            .lineToRelative(Coordinate(x: 0, y: -crenelConfig.depth * direction)),
        ]
        let antiCrenelMove: PathCommand = .lineToRelative(Coordinate(x: antiCrenelActualLength, y: 0))
        let buttEndMove: PathCommand = .lineToRelative(Coordinate(x: buttsEndLength + offsetEnd, y: 0))

        var commands: [PathCommand] = []
        commands.append(buttStartMove)
        if numberOfCrenels > 1 {
            for _ in 1..<numberOfCrenels {
                commands.append(contentsOf: crenelMove)
                commands.append(antiCrenelMove)
            }
        }
        if numberOfCrenels > 0 {
            commands.append(contentsOf: crenelMove)
        }
        commands.append(buttEndMove)
        
        return commands
    }
}
