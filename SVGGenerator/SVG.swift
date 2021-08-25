
import Foundation



enum SVGCoordinateRef {
    
    case relative
    case absolute
}

enum SVGAxis {
    
    case vertical
    case horizontal
    
    func flip() -> SVGAxis {
        
        switch self {
        case .vertical:
            return .horizontal
        case .horizontal:
            return .vertical
        }
    }
}

struct SVGCoordinate {
    
    let x: Float
    let y: Float
    
    func render() -> String {
        
        return "\(x) \(y)"
    }
}

enum SVGPathComponent {
    
    case move(SVGCoordinate, SVGCoordinateRef)
    case line(SVGCoordinate, SVGCoordinateRef)
    case axis(SVGAxis, Float, SVGCoordinateRef)
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

struct SVGPath {
    
    let components: [SVGPathComponent]
    
    func starting(at point: SVGCoordinate) -> SVGPath {
        
        var completedComponents = components
        completedComponents.insert(.move(point, .absolute), at: 0)
        
        return SVGPath(components: completedComponents)
    }
    
    func render() -> String {
        
        return components.map { $0.render() }.joined()
    }
    
    func appending(_ additionalComponents: [SVGPathComponent]) -> SVGPath {
    
        var allComponents = components
        allComponents.append(contentsOf: additionalComponents)

        return SVGPath(components: allComponents)
    }
}

struct SVGPathGroup {
    
    let paths: [SVGPath]
}




struct SVGPathNode {

    let path: SVGPath
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
