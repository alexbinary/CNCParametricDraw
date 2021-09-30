
import Foundation



protocol PathRepresentable {
    
    
    var path: Path { get }
    
    func path(withName: String) -> Path
}


extension PathRepresentable {
    
    
    func path(withName name: String) -> Path {
    
        return Path(fromPath: path, withName: name)
    }
}
