
import Foundation



extension Coordinates {

    
    func render() -> String {
        
        return "\(x) \(y)"
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
