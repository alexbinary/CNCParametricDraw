
import Foundation



struct Coordinate: Equatable {
    
    var x: Float
    var y: Float
    
    mutating func add(_ other: Coordinate) {
        
        self = Coordinate(x: x + other.x, y: y + other.y)
    }
}

struct Size: Equatable {
    
    var width: Float
    var height: Float
    
    static var zero: Size { Size(width: 0, height: 0) }
}

struct Box: Equatable {
    
    var origin: Coordinate
    var size: Size
}

enum PathCommand {
    
    case moveToRelative(Coordinate)
    case lineToRelative(Coordinate)
    case close
}

protocol PathProtocol {
    
    var commands: [PathCommand] { get }
    
    var svgCommands: [SVGPathCommand] { get }
    
    var svgPath: SVGPath { get }
    
    func enumerateCoordinates(block: (Coordinate) -> Void)
    
    var endPoint: Coordinate { get }
    
    var boundingBox: Box { get }
}

extension PathProtocol {
    
    var svgCommands: [SVGPathCommand] {
        
        let svgPathCommands: [SVGPathCommand] = commands.map { pathCommand in
            
            switch pathCommand {
            
            case .moveToRelative(let coordinate):
                return .moveTo(SVGCoordinate(x: coordinate.x, y: coordinate.y), .relative)
                
            case .lineToRelative(let coordinate):
                return .lineTo(SVGCoordinate(x: coordinate.x, y: coordinate.y), .relative)
                
            case .close:
                return .close
            }
        }
        
        return svgPathCommands
    }
    
    var svgPath: SVGPath { SVGPath(withCommands: svgCommands) }
    
    func enumerateCoordinates(block: (Coordinate) -> Void) {
        
        var currentCoordinate = Coordinate(x: 0, y: 0)
        var firstShapePoint: Coordinate? = nil
        
        block(currentCoordinate)
        
        commands.forEach { command in
            
            switch command {
            
            case .moveToRelative(let coordinate):
                
                currentCoordinate.add(coordinate)
                
            case .lineToRelative(let coordinate):
                
                if firstShapePoint == nil {
                    firstShapePoint = currentCoordinate
                }
                currentCoordinate.add(coordinate)
                
            case .close:
                
                currentCoordinate = firstShapePoint!
            }
            
            block(currentCoordinate)
        }
    }
    
    var endPoint: Coordinate {
    
        var currentCoordinate = Coordinate(x: 0, y: 0)
        
        enumerateCoordinates { coordinate in
            
            currentCoordinate = coordinate
        }
        
        return currentCoordinate
    }
    
    var boundingBox: Box {
        
        var smallestCoordinate: Coordinate! = nil
        var biggestCoordinate: Coordinate! = nil
        
        enumerateCoordinates { coordinate in
        
            if smallestCoordinate == nil {
                smallestCoordinate = coordinate
            }
            if biggestCoordinate == nil {
                biggestCoordinate = coordinate
            }
            
            if coordinate.x > biggestCoordinate.x {
                biggestCoordinate.x = coordinate.x
            }
            if coordinate.y > biggestCoordinate.y {
                biggestCoordinate.y = coordinate.y
            }
            
            if coordinate.x < smallestCoordinate.x {
                smallestCoordinate.x = coordinate.x
            }
            if coordinate.y < smallestCoordinate.y {
                smallestCoordinate.y = coordinate.y
            }
        }
        
        let origin: Coordinate! = smallestCoordinate.x < 0 || smallestCoordinate.y < 0 ? smallestCoordinate : Coordinate(x: 0, y: 0)
        let size = Size(width: biggestCoordinate.x - origin.x, height: biggestCoordinate.y - origin.y)
        
        return Box(origin: origin, size: size)
    }
}

struct Path: PathProtocol {
    
    let commands: [PathCommand]
}
