
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

struct CrenelMove {
    
    let totalLength: Float
    let numberOfCrenels: UInt
    let crenelConfig: CrenelConfig
    let direction: CrenelDirection
    let offsetStart: Float
    let offsetEnd: Float
    
    func makePath() -> SVGPath {
        
        let crenelActualLength: Float = crenelConfig.baseLength + crenelConfig.lengthAdjustment
        let antiCrenelActualLength: Float = crenelConfig.baseLength - crenelConfig.lengthAdjustment
        
        let totalCrenelationLength: Float = Float(numberOfCrenels) * crenelActualLength + max(Float(numberOfCrenels) - 1, 0) * antiCrenelActualLength
        
        let buttsTotalLength: Float = totalLength - totalCrenelationLength
        let buttsStartLength: Float = buttsTotalLength/2
        let buttsEndLength: Float = buttsTotalLength - buttsStartLength

        let buttStartMove: SVGPathComponent = .axis(.horizontal, buttsStartLength - offsetStart, .relative)
        let crenelMove: [SVGPathComponent] = [
            .axis(.vertical, crenelConfig.depth * direction, .relative),
            .axis(.horizontal, crenelActualLength, .relative),
            .axis(.vertical, -crenelConfig.depth * direction, .relative),
        ]
        let antiCrenelMove: SVGPathComponent = .axis(.horizontal, antiCrenelActualLength, .relative)
        let buttEndMove: SVGPathComponent = .axis(.horizontal, buttsEndLength + offsetEnd, .relative)

        var pathComponents: [SVGPathComponent] = []
        
        pathComponents.append(buttStartMove)
        if numberOfCrenels > 1 {
            for _ in 1..<numberOfCrenels {
                pathComponents.append(contentsOf: crenelMove)
                pathComponents.append(antiCrenelMove)
            }
        }
        if numberOfCrenels > 0 {
            pathComponents.append(contentsOf: crenelMove)
        }
        pathComponents.append(buttEndMove)
        
        return SVGPath(components: pathComponents)
    }
}
