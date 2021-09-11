
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
        
        let crenelActualLength: Float = (crenelConfig.baseLength + crenelConfig.lengthAdjustment).toMillimeters
        let antiCrenelActualLength: Float = (crenelConfig.baseLength - crenelConfig.lengthAdjustment).toMillimeters
        
        let totalCrenelationLength: Float = Float(actualNumberOfCrenels) * crenelActualLength + max(Float(actualNumberOfCrenels) - 1, 0) * antiCrenelActualLength
        
        let buttsTotalLength: Float = (totalLength - MetricLength(millimeters: totalCrenelationLength)).toMillimeters
        let buttsStartLength: Float = buttsTotalLength/2
        let buttsEndLength: Float = buttsTotalLength - buttsStartLength

        let buttStartPath = Path(withCommands: [.lineToRelative(Coordinates(x: (MetricLength(millimeters: buttsStartLength) - offsetStart).toMillimeters, y: 0))])
        let crenelPath = Path(withCommands: [
            .lineToRelative(Coordinates(x: 0, y: crenelConfig.depth.toMillimeters)),
            .lineToRelative(Coordinates(x: crenelActualLength, y: 0)),
            .lineToRelative(Coordinates(x: 0, y: -crenelConfig.depth.toMillimeters)),
        ])
        let antiCrenelPath = Path(withCommands: [.lineToRelative(Coordinates(x: antiCrenelActualLength, y: 0))])
        let buttEndPath = Path(withCommands: [.lineToRelative(Coordinates(x: (MetricLength(millimeters: buttsEndLength) + offsetEnd).toMillimeters, y: 0))])

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
        
        let punchActualLength: Float = (crenelConfig.baseLength + crenelConfig.lengthAdjustment).toMillimeters
        let antiPunchActualLength: Float = (crenelConfig.baseLength - crenelConfig.lengthAdjustment).toMillimeters
        
        let totalPunchedLength: Float = Float(actualNumberOfPunches) * punchActualLength + max(Float(actualNumberOfPunches) - 1, 0) * antiPunchActualLength
        
        let buttsTotalLength: Float = (totalLength - MetricLength(millimeters: totalPunchedLength)).toMillimeters
        let buttsStartLength: Float = buttsTotalLength/2
        let buttsEndLength: Float = buttsTotalLength - buttsStartLength

        let buttStartPath = Path(withCommands: [.moveToRelative(Coordinates(x: (MetricLength(millimeters: buttsStartLength) - offsetStart).toMillimeters, y: 0))])
        let punchPath = Path(withCommands: [
            .lineToRelative(Coordinates(x: 0, y: crenelConfig.depth.toMillimeters/2)),
            .lineToRelative(Coordinates(x: punchActualLength, y: 0)),
            .lineToRelative(Coordinates(x: 0, y: -crenelConfig.depth.toMillimeters)),
            .lineToRelative(Coordinates(x: -punchActualLength, y: 0)),
            .lineToRelative(Coordinates(x: 0, y: crenelConfig.depth.toMillimeters/2)),
            .moveToRelative(Coordinates(x: punchActualLength, y: 0)),
        ])
        let antiPunchPath = Path(withCommands: [.moveToRelative(Coordinates(x: antiPunchActualLength, y: 0))])
        let buttEndPath = Path(withCommands: [.moveToRelative(Coordinates(x: (MetricLength(millimeters: buttsEndLength) + offsetEnd).toMillimeters, y: 0))])

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
