
import Foundation



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
