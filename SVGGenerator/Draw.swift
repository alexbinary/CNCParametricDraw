
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

struct Path {
    
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
