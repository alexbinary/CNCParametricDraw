
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
}
