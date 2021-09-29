
import Foundation



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
            actualNumberOfCrenels = UInt(max((totalLength - offsetStart + offsetEnd) / crenelConfig.baseLength / 2 - 1, 0))
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
