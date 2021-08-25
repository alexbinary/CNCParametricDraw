
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

enum SVGPathCommand {
    
    case moveTo(SVGCoordinate, SVGCoordinateRef)
    case lineTo(SVGCoordinate, SVGCoordinateRef)
    case axis(SVGAxis, Float, SVGCoordinateRef)
    case close
    
    func render() -> String {
        
        switch self {
        case .moveTo(let coordinate, let coordinateRef):
            return "\(coordinateRef == .absolute ? "M" : "m")\(coordinate.render())"
        case .lineTo(let coordinate, let coordinateRef):
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
    
    let commands: [SVGPathCommand]
    
    func starting(at point: SVGCoordinate) -> SVGPath {
        
        var completedCommands = commands
        completedCommands.insert(.moveTo(point, .absolute), at: 0)
        
        return SVGPath(commands: completedCommands)
    }
    
    func render() -> String {
        
        return commands.map { $0.render() }.joined()
    }
    
    func appending(_ additionalCommands: [SVGPathCommand]) -> SVGPath {
    
        var allCommands = commands
        allCommands.append(contentsOf: additionalCommands)

        return SVGPath(commands: allCommands)
    }
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
