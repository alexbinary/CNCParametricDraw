
import Foundation



struct CrenelConfig {
    
    
    let baseLength: MetricLength
    let lengthAdjustment: MetricLength
    let depth: MetricLength
}



enum NumerOfCrenelsEnum {
    
    
    case manual(UInt)
    case auto
}



struct CrenelSegment: PathRepresentable {

    
    var totalLength: MetricLength
    var numberOfCrenels: NumerOfCrenelsEnum
    var crenelConfig: CrenelConfig
    var offsetStart: MetricLength
    var offsetEnd: MetricLength
    
    
    var path: Path {
        
        var actualNumberOfCrenels: UInt = 0
        
        switch numberOfCrenels {
        case .auto:
            actualNumberOfCrenels = UInt(max((totalLength - offsetStart + offsetEnd).toMillimeters / crenelConfig.baseLength.toMillimeters / 2 - 1, 0))
        case .manual(let n):
            actualNumberOfCrenels = n
        }
        
        let crenelActualLength = crenelConfig.baseLength + crenelConfig.lengthAdjustment
        let antiCrenelActualLength = crenelConfig.baseLength - crenelConfig.lengthAdjustment
        
        let totalCrenelationLength = Float(actualNumberOfCrenels) * crenelActualLength + max(Float(actualNumberOfCrenels) - 1, 0) * antiCrenelActualLength
        
        let buttsTotalLength = totalLength - totalCrenelationLength
        let buttsStartLength = buttsTotalLength/2
        let buttsEndLength = buttsTotalLength - buttsStartLength

        let buttStartPath = Path(withCommands: [.lineToRelative(Coordinates(x: (buttsStartLength - offsetStart).toMillimeters, y: 0))])
        let crenelPath = Path(withCommands: [
            .lineToRelative(Coordinates(x: 0, y: crenelConfig.depth.toMillimeters)),
            .lineToRelative(Coordinates(x: crenelActualLength.toMillimeters, y: 0)),
            .lineToRelative(Coordinates(x: 0, y: -crenelConfig.depth.toMillimeters)),
        ])
        let antiCrenelPath = Path(withCommands: [.lineToRelative(Coordinates(x: antiCrenelActualLength.toMillimeters, y: 0))])
        let buttEndPath = Path(withCommands: [.lineToRelative(Coordinates(x: (buttsEndLength + offsetEnd).toMillimeters, y: 0))])

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



struct PunchesSegment: PathRepresentable {

    
    var totalLength: MetricLength
    var numberOfPunches: NumerOfCrenelsEnum
    var crenelConfig: CrenelConfig
    var offsetStart: MetricLength
    var offsetEnd: MetricLength
    
    
    var path: Path {
        
        var actualNumberOfPunches: UInt = 0
        
        switch numberOfPunches {
        case .auto:
            actualNumberOfPunches = UInt(max((totalLength - offsetStart + offsetEnd).toMillimeters / crenelConfig.baseLength.toMillimeters / 2 - 1, 0))
        case .manual(let n):
            actualNumberOfPunches = n
        }
        
        let punchActualLength = crenelConfig.baseLength + crenelConfig.lengthAdjustment
        let antiPunchActualLength = crenelConfig.baseLength - crenelConfig.lengthAdjustment
        
        let totalPunchedLength = Float(actualNumberOfPunches) * punchActualLength + max(Float(actualNumberOfPunches) - 1, 0) * antiPunchActualLength
        
        let buttsTotalLength = totalLength - totalPunchedLength
        let buttsStartLength = buttsTotalLength/2
        let buttsEndLength = buttsTotalLength - buttsStartLength

        let buttStartPath = Path(withCommands: [.moveToRelative(Coordinates(x: (buttsStartLength - offsetStart).toMillimeters, y: 0))])
        let punchPath = Path(withCommands: [
            .lineToRelative(Coordinates(x: 0, y: crenelConfig.depth.toMillimeters/2)),
            .lineToRelative(Coordinates(x: punchActualLength.toMillimeters, y: 0)),
            .lineToRelative(Coordinates(x: 0, y: -crenelConfig.depth.toMillimeters)),
            .lineToRelative(Coordinates(x: -punchActualLength.toMillimeters, y: 0)),
            .lineToRelative(Coordinates(x: 0, y: crenelConfig.depth.toMillimeters/2)),
            .moveToRelative(Coordinates(x: punchActualLength.toMillimeters, y: 0)),
        ])
        let antiPunchPath = Path(withCommands: [.moveToRelative(Coordinates(x: antiPunchActualLength.toMillimeters, y: 0))])
        let buttEndPath = Path(withCommands: [.moveToRelative(Coordinates(x: (buttsEndLength + offsetEnd).toMillimeters, y: 0))])

        var totalPath: Path = .empty
        totalPath.append(buttStartPath)
        if actualNumberOfPunches > 1 {
            for _ in 1..<actualNumberOfPunches {
                totalPath.append(punchPath)
                totalPath.append(antiPunchPath)
            }
        }
        if actualNumberOfPunches > 0 {
            totalPath.append(punchPath)
        }
        totalPath.append(buttEndPath)
        
        return totalPath
    }
}
