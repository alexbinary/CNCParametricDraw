
import Foundation



protocol Renderer {
    
    
    func writeSvgFile(withRootPathsLayout pathsLayout: PathsLayout, to url: URL)
}
