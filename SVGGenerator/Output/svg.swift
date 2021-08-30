
import Foundation



enum SVGCoordinateRef {

    case relative
    case absolute
}



enum SVGAxis {
    
    case vertical
    case horizontal
}



struct SVGCoordinates {

    
    let x: Float
    let y: Float
    
    
    func render() -> String {
        
        return "\(x) \(y)"
    }
}



enum SVGPathCommand {

    
    case moveTo(SVGCoordinates, SVGCoordinateRef)
    case lineTo(SVGCoordinates, SVGCoordinateRef)
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
    
    
    init(withCommands commands: [SVGPathCommand]) {
        
        self.commands = commands
    }
    
    
    func withInitialAbsoluteMove(to coordinates: SVGCoordinates) -> SVGPath {
        
        var completedCommands = commands
        completedCommands.insert(.moveTo(coordinates, .absolute), at: 0)
        
        return SVGPath(withCommands: completedCommands)
    }
    
    
    func render() -> String {
        
        return commands.map { $0.render() }.joined()
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

    
    let pathNodes: [SVGPathNode]
    
    
    func render() -> String {
    
        return """
            <svg viewBox="0 0 3178.5827 4493.8583">
                \(pathNodes.map { $0.render() } .joined(separator: "\n") )
            </svg>
            """
    }
}



extension PathProtocol {
    
    
    var svgCommands: [SVGPathCommand] {
        
        let svgCommands: [SVGPathCommand] = commands.map { command in
            
            switch command {
            
            case .moveToRelative(let coordinate):
                
                return .moveTo(SVGCoordinates(x: coordinate.x, y: coordinate.y), .relative)
                
            case .lineToRelative(let coordinate):
                
                return .lineTo(SVGCoordinates(x: coordinate.x, y: coordinate.y), .relative)
                
            case .close:
                
                return .close
            }
        }
        
        return svgCommands
    }
    
    
    var svgPath: SVGPath { SVGPath(withCommands: svgCommands) }
}
