
import Foundation



public enum PathsLayoutItem {
    
    
    case path(Path)
    case layout(PathsLayout)
    
    
    var boundingBox: Rect {
        
        switch self {
        
        case .path(let path):
            return path.boundingBox
            
        case .layout(let layout):
            return layout.boundingBox
        }
    }
}
