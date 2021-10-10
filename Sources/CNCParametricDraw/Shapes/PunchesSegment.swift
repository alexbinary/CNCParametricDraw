
import Foundation



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
            actualNumberOfPunches = UInt(max((totalLength - offsetStart + offsetEnd) / crenelConfig.baseLength / 2 - 1, 0))
        case .manual(let n):
            actualNumberOfPunches = n
        }
        
        let punchActualLength = crenelConfig.baseLength + crenelConfig.lengthAdjustment
        let antiPunchActualLength = crenelConfig.baseLength - crenelConfig.lengthAdjustment
        
        let totalPunchedLength = Float(actualNumberOfPunches) * punchActualLength + max(Float(actualNumberOfPunches) - 1, 0) * antiPunchActualLength
        
        let buttsTotalLength = totalLength - totalPunchedLength
        let buttsStartLength = buttsTotalLength/2
        let buttsEndLength = buttsTotalLength - buttsStartLength
        
        let punchWidth = crenelConfig.depth + 0.5.mm

        let buttStartPath = Path(withCommands: [.moveToRelative(Coordinates(x: (buttsStartLength - offsetStart).toMillimeters, y: 0))])
        let punchPath = Path(withCommands: [
            .lineToRelative(Coordinates(x: 0, y: (punchWidth/2).toMillimeters)),
            .lineToRelative(Coordinates(x: punchActualLength.toMillimeters, y: 0)),
            .lineToRelative(Coordinates(x: 0, y: -punchWidth.toMillimeters)),
            .lineToRelative(Coordinates(x: -punchActualLength.toMillimeters, y: 0)),
            .lineToRelative(Coordinates(x: 0, y: (punchWidth/2).toMillimeters)),
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
