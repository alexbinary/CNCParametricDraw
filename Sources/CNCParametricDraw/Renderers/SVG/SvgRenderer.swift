
import Foundation



extension Float {

    
    func render() -> String {
        
        var str = "\(self)"
        
        if str == "-0.0" { str = "0" }
        if str == "0.0" { str = "0" }
        
        return str
    }
}



extension Coordinates {

    
    func render() -> String {
        
        return "\(x.render()) \(y.render())"
    }
}



public struct SvgRenderer: Renderer {
    
    
    let defaultPathStyle: String
    
    
    public init(defaultPathStyle: String) {
        
        self.defaultPathStyle = defaultPathStyle
    }
    
    
    public func renderFile(withRootPathsLayout pathsLayout: PathsLayout, writeContentToFileAt url: URL) {
        
        let fileContent = SvgFile(pathNodes: svgPathNodes(renderedFromLayout: pathsLayout, at: .zero)).render()

        try! fileContent.data(using: .utf8)!.write(to: url)
        
        print("SVG file written to \(url)")

        return
    }
    
    
    func svgPathNodes(renderedFromLayout pathsLayout: PathsLayout, at coordinates: Coordinates) -> [SvgPathNode] {
        
        return pathsLayout.elements.reduce(into: []) { (nodes, element) in
            
            switch element.item {
            
            case .path(let path):
                
                nodes.append(svgPathNode(renderedFromPath: path, at: element.position))
                
            case .layout(let layout):
                
                nodes.append(contentsOf: svgPathNodes(renderedFromLayout: layout, at: element.position))
            }
        }
    }
    
    
    func svgPathNode(renderedFromPath path: Path, at coordinates: Coordinates) -> SvgPathNode {
        
        return SvgPathNode(
            
            path: svgPath(renderedFromPath: path).withInitialAbsoluteMove(to: coordinates),
            pathStyle: defaultPathStyle,
            nodeId: path.name
        )
    }
    
    
    func svgPath(renderedFromPath path: Path) -> SvgPath {
        
        return SvgPath(withCommands: path.commands.map { command in
            
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
