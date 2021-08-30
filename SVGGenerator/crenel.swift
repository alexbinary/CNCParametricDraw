
import Foundation



struct CrenelConfig {
    
    
    let baseLength: Float
    let lengthAdjustment: Float
    let depth: Float
}



class CrenelPath: Path {

    
    init(
        totalLength: Float,
        numberOfCrenels: UInt,
        crenelConfig: CrenelConfig,
        offsetStart: Float,
        offsetEnd: Float
    ) {
     
        let crenelActualLength: Float = crenelConfig.baseLength + crenelConfig.lengthAdjustment
        let antiCrenelActualLength: Float = crenelConfig.baseLength - crenelConfig.lengthAdjustment
        
        let totalCrenelationLength: Float = Float(numberOfCrenels) * crenelActualLength + max(Float(numberOfCrenels) - 1, 0) * antiCrenelActualLength
        
        let buttsTotalLength: Float = totalLength - totalCrenelationLength
        let buttsStartLength: Float = buttsTotalLength/2
        let buttsEndLength: Float = buttsTotalLength - buttsStartLength

        let buttStartPath = Path(withCommands: [.lineToRelative(Coordinates(x: buttsStartLength - offsetStart, y: 0))])
        let crenelPath = Path(withCommands: [
            .lineToRelative(Coordinates(x: 0, y: crenelConfig.depth)),
            .lineToRelative(Coordinates(x: crenelActualLength, y: 0)),
            .lineToRelative(Coordinates(x: 0, y: -crenelConfig.depth)),
        ])
        let antiCrenelPath = Path(withCommands: [.lineToRelative(Coordinates(x: antiCrenelActualLength, y: 0))])
        let buttEndPath = Path(withCommands: [.lineToRelative(Coordinates(x: buttsEndLength + offsetEnd, y: 0))])

        let totalPath: Path = .empty
        totalPath.append(buttStartPath)
        if numberOfCrenels > 1 {
            for _ in 1..<numberOfCrenels {
                totalPath.append(crenelPath)
                totalPath.append(antiCrenelPath)
            }
        }
        if numberOfCrenels > 0 {
            totalPath.append(crenelPath)
        }
        totalPath.append(buttEndPath)
        
        super.init(fromPath: totalPath)
    }
}
