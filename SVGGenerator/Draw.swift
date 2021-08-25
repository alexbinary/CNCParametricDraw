
import Foundation



struct Coordinate: Equatable {
    
    let x: Float
    let y: Float
    
    mutating func add(_ other: Coordinate) {
        
        self = Coordinate(x: x + other.x, y: y + other.y)
    }
}

enum PathCommand {
    
    case moveTo(Coordinate)
    case lineTo(Coordinate)
    case close
}

protocol Path {
    
    var commands: [PathCommand] { get }
    
    var endPoint: Coordinate { get }
    
    var svgPathCommands: [SVGPathCommand] { get }
}

extension Path {
    
    var endPoint: Coordinate {
        
        var currentCoordinate = Coordinate(x: 0, y: 0)
        var firstShapePoint: Coordinate? = nil
        
        commands.forEach { command in
            
            switch command {
            
            case .moveTo(let coordinate):
                
                currentCoordinate.add(coordinate)
                
            case .lineTo(let coordinate):
                
                if firstShapePoint == nil {
                    firstShapePoint = currentCoordinate
                }
                currentCoordinate.add(coordinate)
                
            case .close:
                
                currentCoordinate = firstShapePoint!
            }
        }
        
        return currentCoordinate
    }
    
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
    
struct SinglePath: Path {
    
    let commands: [PathCommand]
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
}
