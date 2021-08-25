
import Foundation



struct Coordinate {
    
    let x: Float
    let y: Float
}

enum PathCommand {
    
    case moveTo(Coordinate)
    case lineTo(Coordinate)
    case close
}

protocol Path {
    
    var commands: [PathCommand] { get }
    
    var svgPathCommands: [SVGPathCommand] { get }
}
    
struct SinglePath: Path {
    
    let commands: [PathCommand]
    
    var svgPathCommands: [SVGPathCommand] {
        
        let svgPathCommands: [SVGPathCommand] = commands.map { pathCommand in
            
            switch pathCommand {
            
            case .moveTo(let coordinate):
                return .moveTo(SVGCoordinate(x: coordinate.x, y: coordinate.y), .relative)
                
            case .lineTo(let coordinate):
                return .lineTo(SVGCoordinate(x: coordinate.x, y: coordinate.y), .relative)
                
            case .close:
                return .close
            }
        }
        
        return svgPathCommands
    }
}

struct PathGroup: Path {
    
    let paths: [Path]
    
    var commands: [PathCommand] {
        
        let commands: [PathCommand] = paths.reduce([PathCommand]()) { result, path in
            var expandedResult = result
            expandedResult.append(contentsOf: path.commands)
            return expandedResult
        }
        
        return commands
    }
    
    var svgPathCommands: [SVGPathCommand] {
        
        return SinglePath(commands: commands).svgPathCommands
    }
}
