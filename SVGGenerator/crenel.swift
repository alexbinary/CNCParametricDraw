
import Foundation



struct CrenelConfig {
    
    
    let baseLength: Float
    let lengthAdjustment: Float
    let depth: Float
}



struct CrenelPath: Path {

    
    let totalLength: Float
    let numberOfCrenels: UInt
    let crenelConfig: CrenelConfig
    let offsetStart: Float
    let offsetEnd: Float
    
    
    var commands: [PathCommand] {
        
        let crenelActualLength: Float = crenelConfig.baseLength + crenelConfig.lengthAdjustment
        let antiCrenelActualLength: Float = crenelConfig.baseLength - crenelConfig.lengthAdjustment
        
        let totalCrenelationLength: Float = Float(numberOfCrenels) * crenelActualLength + max(Float(numberOfCrenels) - 1, 0) * antiCrenelActualLength
        
        let buttsTotalLength: Float = totalLength - totalCrenelationLength
        let buttsStartLength: Float = buttsTotalLength/2
        let buttsEndLength: Float = buttsTotalLength - buttsStartLength

        let buttStartMove: PathCommand = .lineToRelative(Coordinates(x: buttsStartLength - offsetStart, y: 0))
        let crenelMove: [PathCommand] = [
            .lineToRelative(Coordinates(x: 0, y: crenelConfig.depth)),
            .lineToRelative(Coordinates(x: crenelActualLength, y: 0)),
            .lineToRelative(Coordinates(x: 0, y: -crenelConfig.depth)),
        ]
        let antiCrenelMove: PathCommand = .lineToRelative(Coordinates(x: antiCrenelActualLength, y: 0))
        let buttEndMove: PathCommand = .lineToRelative(Coordinates(x: buttsEndLength + offsetEnd, y: 0))

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
