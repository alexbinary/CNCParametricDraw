
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
    
    func render() -> String {
        
        return "\(x) \(y)"
    }
}

enum SVGConcretePathComponent {
    
    case move(SVGConcreteCoordinate, SVGCoordinateRef)
    case line(SVGConcreteCoordinate, SVGCoordinateRef)
    case axis(SVGConcreteAxis, Float, SVGCoordinateRef)
    case close
    
    func render() -> String {
        
        switch self {
        case .move(let coordinate, let coordinateRef):
            return "\(coordinateRef == .absolute ? "M" : "m")\(coordinate.render())"
        case .line(let coordinate, let coordinateRef):
            return "\(coordinateRef == .absolute ? "L" : "l")\(coordinate.render())"
        case .axis(let axis, let value, let coordinateRef):
            let opCode = axis == .horizontal ? "h" : "v"
            return "\(coordinateRef == .absolute ? opCode.uppercased() : opCode)\(value)"
        case .close:
            return "Z"
        }
    }
}

struct SVGConcretePath {
    
    let components: [SVGConcretePathComponent]
    
    func starting(at point: SVGConcreteCoordinate) -> SVGConcretePath {
        
        var completedComponents = components
        completedComponents.insert(.move(point, .absolute), at: 0)
        
        return SVGConcretePath(components: completedComponents)
    }
    
    func render() -> String {
        
        return components.map { $0.render() }.joined()
    }
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
    case close
    
    func resolve(usingAsMainAxis mainAxis: SVGConcreteAxis) -> SVGConcretePathComponent {
        
        switch self {
        case .move(let coordinate, let coordinateRef):
            return .move(coordinate.resolve(usingAsMainAxis: mainAxis), coordinateRef)
        case .line(let coordinate, let coordinateRef):
            return .line(coordinate.resolve(usingAsMainAxis: mainAxis), coordinateRef)
        case .axis(let axis, let value, let coordinateRef):
            return .axis(axis.resolve(usingAsMainAxis: mainAxis), value, coordinateRef)
        case .close:
            return .close
        }
    }
}

struct SVGAbstractPath {
    
    let components: [SVGAbstractPathComponent]
    
    func appending(_ additionalComponents: [SVGAbstractPathComponent]) -> SVGAbstractPath {
        
        var allComponents = components
        allComponents.append(contentsOf: additionalComponents)
        
        return SVGAbstractPath(components: allComponents)
    }
    
    func resolve(usingAsMainAxis mainAxis: SVGConcreteAxis) -> SVGConcretePath {
        
        return SVGConcretePath(components: components.map { $0.resolve(usingAsMainAxis: mainAxis) })
    }
}



struct SVGPathNode {

    let path: SVGConcretePath
    let pathStyle: String
    let nodeId: String
    
    func render() -> String {
    
        return """
            <path
            style="\(pathStyle)"
            d="\(path.render())"
            id="\(nodeId)"/>
            """
    }
}

struct SVGFile {
    
    let pathsNodes: [SVGPathNode]
    
    func render() -> String {
    
        return """
            <svg viewBox="0 0 3178.5827 4493.8583">
                \(pathsNodes.map { $0.render() } .joined(separator: "\n") )
            </svg>
            """
    }
}
