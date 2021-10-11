
import Foundation



public protocol Renderer {
    
    
    func renderFile(withRootPathsLayout pathsLayout: PathsLayout, writeContentToFileAt url: URL)
}
