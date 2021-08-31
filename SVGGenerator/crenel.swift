
import Foundation



struct CrenelConfig {
    
    
    let baseLength: Float
    let lengthAdjustment: Float
    let depth: Float
}



enum NumerOfCrenelsEnum {
    
    
    case manual(UInt)
    case auto
}



struct CrenelSegment: PathRepresentable {

    
    var totalLength: Float
    var numberOfCrenels: NumerOfCrenelsEnum
    var crenelConfig: CrenelConfig
    var offsetStart: Float
    var offsetEnd: Float
    
    
    var path: Path {
        
        var actualNumberOfCrenels: UInt = 0
        
        switch numberOfCrenels {
        case .auto:
            actualNumberOfCrenels = UInt(max((totalLength - offsetStart + offsetEnd) / crenelConfig.baseLength / 2 - 1, 0))
        case .manual(let n):
            actualNumberOfCrenels = n
        }
        
        let crenelActualLength: Float = crenelConfig.baseLength + crenelConfig.lengthAdjustment
        let antiCrenelActualLength: Float = crenelConfig.baseLength - crenelConfig.lengthAdjustment
        
        let totalCrenelationLength: Float = Float(actualNumberOfCrenels) * crenelActualLength + max(Float(actualNumberOfCrenels) - 1, 0) * antiCrenelActualLength
        
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

        var totalPath: Path = .empty
        totalPath.append(buttStartPath)
        if actualNumberOfCrenels > 1 {
            for _ in 1..<actualNumberOfCrenels {
                totalPath.append(crenelPath)
                totalPath.append(antiCrenelPath)
            }
        }
        if actualNumberOfCrenels > 0 {
            totalPath.append(crenelPath)
        }
        totalPath.append(buttEndPath)
        
        return totalPath
    }
}
