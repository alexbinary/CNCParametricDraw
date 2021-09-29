
import Foundation



enum SVGCoordinateRef {

    case relative
    case absolute
}



enum SVGAxis {
    
    case vertical
    case horizontal
}



extension Coordinates {

    
    func render() -> String {
        
        return "\(x) \(y)"
    }
}



enum SVGPathCommand {

    
    case moveTo(Coordinates, SVGCoordinateRef)
    case lineTo(Coordinates, SVGCoordinateRef)
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
    
    
    func withInitialAbsoluteMove(to coordinates: Coordinates) -> SVGPath {
        
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


public struct SVGRenderer: Renderer {
    
    
    let defaultPathStyle: String
    
    
    public init(defaultPathStyle: String) {
        
        self.defaultPathStyle = defaultPathStyle
    }
    
    
    public func renderFile(withRootPathsLayout pathsLayout: PathsLayout) -> String {
        
        return SVGFile(pathNodes: svgPathNodes(renderedFromLayout: pathsLayout, at: .zero)).render()
    }
    
    
    func svgPathNodes(renderedFromLayout pathsLayout: PathsLayout, at coordinates: Coordinates) -> [SVGPathNode] {
        
        return pathsLayout.elements.reduce(into: []) { (nodes, element) in
            
            switch element.item {
            
            case .path(let path):
                
                nodes.append(svgPathNode(renderedFromPath: path, at: element.position))
                
            case .layout(let layout):
                
                nodes.append(contentsOf: svgPathNodes(renderedFromLayout: layout, at: element.position))
            }
        }
    }
    
    
    func svgPathNode(renderedFromPath path: Path, at coordinates: Coordinates) -> SVGPathNode {
        
        return SVGPathNode(
            
            path: svgPath(renderedFromPath: path).withInitialAbsoluteMove(to: coordinates),
            pathStyle: defaultPathStyle,
            nodeId: path.name
        )
    }
    
    
    func svgPath(renderedFromPath path: Path) -> SVGPath {
        
        return SVGPath(withCommands: path.commands.map { command in
            
            switch command {
            
            case .moveToRelative(let coordinates):
                
                return .moveTo(coordinates, .relative)
                
            case .lineToRelative(let coordinates):
                
                return .lineTo(coordinates, .relative)
                
            case .close:
                
                return .close
            }
        })
    }
}
