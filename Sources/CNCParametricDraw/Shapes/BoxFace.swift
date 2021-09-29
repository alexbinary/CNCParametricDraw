
import Foundation



struct BoxFace: PathRepresentable {
        
    
    var width: MetricLength
    var height: MetricLength
    
    var leftCrenelConfig: BoxFaceCrenelConfig?
    var rightCrenelConfig: BoxFaceCrenelConfig?
    var topCrenelConfig: BoxFaceCrenelConfig?
    var bottomCrenelConfig: BoxFaceCrenelConfig?
    
    var punchLinesPositionsY: [MetricLength] = []
    var punchLinesCrenelConfig: CrenelConfig? = nil
    
    
    var path: Path {
         
        var totalPath: Path = .empty
        
        let offsetLeft = leftCrenelConfig != nil && leftCrenelConfig!.direction == .external ? leftCrenelConfig!.crenelConfig.depth : 0.mm
        let offsetRight = rightCrenelConfig != nil && rightCrenelConfig!.direction == .external ? rightCrenelConfig!.crenelConfig.depth : 0.mm
        
        let offsetTop = topCrenelConfig != nil && topCrenelConfig!.direction == .external ? topCrenelConfig!.crenelConfig.depth : 0.mm
        let offsetBottom = bottomCrenelConfig != nil && bottomCrenelConfig!.direction == .external ? bottomCrenelConfig!.crenelConfig.depth : 0.mm
        
        totalPath.append(.moveToRelative(Coordinates(x: offsetLeft.toMillimeters, y: offsetTop.toMillimeters)))
        
        let horizontalLength = width - offsetLeft - offsetRight
        let verticalLength = height - offsetTop - offsetBottom
        
        if let crenelConfig = leftCrenelConfig {
            
            var crenelPath = CrenelSegment(
                totalLength: height,
                numberOfCrenels: crenelConfig.numberOfCrenels,
                crenelConfig: crenelConfig.crenelConfig,
                offsetStart: offsetTop,
                offsetEnd: -offsetBottom
            ).path.rotated90DegreesClockWise
            
            if crenelConfig.direction == .internal {
                crenelPath.mirrorX()
            }
            
            totalPath.append(crenelPath)
        } else {
            totalPath.append(.lineToRelative(Coordinates(x: 0, y: verticalLength.toMillimeters)))
        }
        
        if let crenelConfig = bottomCrenelConfig {
            
            var crenelPath = CrenelSegment(
                totalLength: width,
                numberOfCrenels: crenelConfig.numberOfCrenels,
                crenelConfig: crenelConfig.crenelConfig,
                offsetStart: offsetLeft,
                offsetEnd: -offsetRight
            ).path
            
            if crenelConfig.direction == .internal {
                crenelPath.mirrorY()
            }
            
            totalPath.append(crenelPath)
        } else {
            totalPath.append(.lineToRelative(Coordinates(x: horizontalLength.toMillimeters, y: 0)))
        }
        
        if let crenelConfig = rightCrenelConfig {
            
            var crenelPath = CrenelSegment(
                totalLength: height,
                numberOfCrenels: crenelConfig.numberOfCrenels,
                crenelConfig: crenelConfig.crenelConfig,
                offsetStart: offsetBottom,
                offsetEnd: -offsetTop
            ).path.rotated270DegreesClockWise
            
            if crenelConfig.direction == .internal {
                crenelPath.mirrorX()
            }
            
            totalPath.append(crenelPath)
        } else {
            totalPath.append(.lineToRelative(Coordinates(x: 0, y: -verticalLength.toMillimeters)))
        }
        
        if let crenelConfig = topCrenelConfig {
            
            var crenelPath = CrenelSegment(
                totalLength: width,
                numberOfCrenels: crenelConfig.numberOfCrenels,
                crenelConfig: crenelConfig.crenelConfig,
                offsetStart: offsetRight,
                offsetEnd: -offsetLeft
            ).path.rotated180DegreesClockWise
            
            if crenelConfig.direction == .internal {
                crenelPath.mirrorY()
            }
            
            totalPath.append(crenelPath)
        } else {
            totalPath.append(.lineToRelative(Coordinates(x: -horizontalLength.toMillimeters, y: 0)))
        }
        
        if !punchLinesPositionsY.isEmpty {
            
            totalPath.append(.moveToRelative(Coordinates(x: -offsetLeft.toMillimeters, y: (-offsetTop + height).toMillimeters)))
            
            punchLinesPositionsY.dropLast().forEach { h in
                
                let punchPath = PunchesSegment(
                    totalLength: width,
                    numberOfPunches: .auto,
                    crenelConfig: punchLinesCrenelConfig!,
                    offsetStart: 0.mm,
                    offsetEnd: 0.mm
                ).path
                
                totalPath.append(.moveToRelative(Coordinates(x: 0, y: -h.toMillimeters)))
                totalPath.append(punchPath)
                totalPath.append(.moveToRelative(Coordinates(x: -width.toMillimeters, y: 0)))
            }
        }
        
        return totalPath
    }
}
