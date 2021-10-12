
import Foundation



struct SvgPath {
    
    
    let commands: [SvgPathCommand]
    
    
    init(withCommands commands: [SvgPathCommand]) {
        
        self.commands = commands
    }
    
    
    func withInitialAbsoluteMove(to coordinates: Coordinates) -> SvgPath {
        
        var completedCommands = commands
        completedCommands.insert(.moveTo(coordinates, .absolute), at: 0)
        
        return SvgPath(withCommands: completedCommands)
    }
    
    
    func render() -> String {
        
        return commands.map { $0.render() }.joined()
    }
    
    
    var optimized: SvgPath {
        
        return SvgPath(withCommands: self.commands.compactMap { command in
            
            switch command {
            
            case .axis, .close:
                
                return command
                
            case .moveTo(let coordinates, let ref):
                
                if coordinates == .zero, ref == .relative {
                    return nil
                }
                return command
                
            case .lineTo(let coordinates, let ref):
                
                if coordinates == .zero, ref == .relative {
                    return nil
                }
                if coordinates.x == 0 {
                    return .axis(.vertical, coordinates.y, ref)
                }
                if coordinates.y == 0 {
                    return .axis(.horizontal, coordinates.x, ref)
                }
                return command
            }
        })
    }
}
