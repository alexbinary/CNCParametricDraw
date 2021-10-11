
import Foundation



protocol Renderer {
    
    
    func renderFile(withRootPathsLayout pathsLayout: PathsLayout, writeContentToFileAt url: URL)
}
