
import Foundation



enum SVGCoordinateRef {
    
    case relative
    case absolute
}

enum SVGConcreteAxis {
    
    case vertical
    case horizontal
}

struct SVGConcreteCoordinate {
    
    let x: Float
    let y: Float
}

enum SVGConcretePathComponent {
    
    case move(SVGConcreteCoordinate, SVGCoordinateRef)
    case line(SVGConcreteCoordinate, SVGCoordinateRef)
    case axis(SVGConcreteAxis, Float, SVGCoordinateRef)
}

struct SVGConcretePath {
    
    let components: [SVGConcretePathComponent]
}




enum SVGAbstractAxis {
    
    case main
    case secondary
    
    func resolve(usingAsMainAxis mainAxis: SVGConcreteAxis) -> SVGConcreteAxis {
        
        switch mainAxis {
        case .horizontal:
            switch self {
            case .main:
                return .horizontal
            case .secondary:
                return .vertical
            }
        case .vertical:
            switch self {
            case .main:
                return .vertical
            case .secondary:
                return .horizontal
            }
        }
    }
}

struct SVGAbstractCoordinate {
    
    let mainAxisValue: Float
    let secondaryAxisValue: Float
    
    func resolve(usingAsMainAxis mainAxis: SVGConcreteAxis) -> SVGConcreteCoordinate {
        
        switch mainAxis {
        case .horizontal:
            return SVGConcreteCoordinate(x: mainAxisValue, y: secondaryAxisValue)
        case .vertical:
            return SVGConcreteCoordinate(x: secondaryAxisValue, y: mainAxisValue)
        }
    }
}

enum SVGAbstractPathComponent {
    
    case move(SVGAbstractCoordinate, SVGCoordinateRef)
    case line(SVGAbstractCoordinate, SVGCoordinateRef)
    case axis(SVGAbstractAxis, Float, SVGCoordinateRef)
    
    func resolve(usingAsMainAxis mainAxis: SVGConcreteAxis) -> SVGConcretePathComponent {
        
        switch self {
        case .move(let coordinate, let coordinateRef):
            return .move(coordinate.resolve(usingAsMainAxis: mainAxis), coordinateRef)
        case .line(let coordinate, let coordinateRef):
            return .line(coordinate.resolve(usingAsMainAxis: mainAxis), coordinateRef)
        case .axis(let axis, let value, let coordinateRef):
            return .axis(axis.resolve(usingAsMainAxis: mainAxis), value, coordinateRef)
        }
    }
}

struct SVGAbstractPath {
    
    let components: [SVGAbstractPathComponent]
    
    func resolve(usingAsMainAxis mainAxis: SVGConcreteAxis) -> SVGConcretePath {
        
        return SVGConcretePath(components: components.map { $0.resolve(usingAsMainAxis: mainAxis) })
    }
}
