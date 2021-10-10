
import Foundation



struct SvgFile {

    
    let pathNodes: [SvgPathNode]
    
    let documentWidth = 3178.0
    let documentHeight = 4493.0
    let documentSizeUnit = "mm"
    
    
    func render() -> String {
    
        return """
            <svg width="\(documentWidth)\(documentSizeUnit)" height="\(documentHeight)\(documentSizeUnit)" viewBox="0 0 \(documentWidth) \(documentHeight)">
                \(pathNodes.map { $0.render() } .joined(separator: "\n") )
            </svg>
            """
    }
}
