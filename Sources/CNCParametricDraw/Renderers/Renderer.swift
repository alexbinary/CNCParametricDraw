
import Foundation



protocol Renderer {
    
    
    func writeSVGFile(withRootPathsLayout pathsLayout: PathsLayout, to url: URL)
}
