
import Foundation



struct SvgPathNode {

    
    let path: SvgPath
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
