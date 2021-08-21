
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
    
    func makePath() -> SVGAbstractPath {
        
        let crenelActualLength: Float = crenelConfig.baseLength + crenelConfig.lengthAdjustment
        let antiCrenelActualLength: Float = crenelConfig.baseLength - crenelConfig.lengthAdjustment
        
        let totalCrenelationLength: Float = Float(numberOfCrenels) * crenelActualLength + max(Float(numberOfCrenels) - 1, 0) * antiCrenelActualLength
        
        let buttsTotalLength: Float = totalLength - totalCrenelationLength
        let buttsStartLength: Float = buttsTotalLength/2
        let buttsEndLength: Float = buttsTotalLength - buttsStartLength

        let buttStartMove: SVGAbstractPathComponent = .axis(.main, buttsStartLength - offsetStart, .relative)
        let crenelMove: [SVGAbstractPathComponent] = [
            .axis(.secondary, crenelConfig.depth * direction, .relative),
            .axis(.main, crenelActualLength, .relative),
            .axis(.secondary, -crenelConfig.depth * direction, .relative),
        ]
        let antiCrenelMove: SVGAbstractPathComponent = .axis(.main, antiCrenelActualLength, .relative)
        let buttEndMove: SVGAbstractPathComponent = .axis(.main, buttsEndLength + offsetEnd, .relative)

        var pathComponents: [SVGAbstractPathComponent] = []
        
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
        
        return SVGAbstractPath(components: pathComponents)
    }
}
