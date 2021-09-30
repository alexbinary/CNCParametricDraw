
import Foundation



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
