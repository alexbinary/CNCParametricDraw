
import Foundation



struct SVGPath {
    
    
    let commands: [SVGPathCommand]
    
    
    init(withCommands commands: [SVGPathCommand]) {
        
        self.commands = commands
    }
    
    
    func withInitialAbsoluteMove(to coordinates: Coordinates) -> SVGPath {
        
        var completedCommands = commands
        completedCommands.insert(.moveTo(coordinates, .absolute), at: 0)
        
        return SVGPath(withCommands: completedCommands)
    }
    
    
    func render() -> String {
        
        return commands.map { $0.render() }.joined()
    }
}
