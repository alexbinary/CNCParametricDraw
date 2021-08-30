
import Foundation



struct Coordinate: Equatable {
    
    var x: Float
    var y: Float
    
    mutating func add(_ other: Coordinate) {
        
        self = Coordinate(x: x + other.x, y: y + other.y)
    }
    
    var flipped: Coordinate { Coordinate(x: y, y: x) }
    
    var mirrorX: Coordinate { Coordinate(x: -x, y: y) }
    
    var mirrorY: Coordinate { Coordinate(x: x, y: -y) }
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
    
    var endPoint: Coordinate { get }
    
    var boundingBox: Box { get }
    
    var flipped: Path { get }
    
    var mirrorX: Path { get }
    
    var mirrorY: Path { get }
    
    var rotated90DegreesClockWise: Path { get }
    
    func enumerateCoordinates(block: (Coordinate) -> Void)
    
    func withCommandsTransformedWith(transform: (PathCommand) -> PathCommand) -> Path
    
    func withCommandsCoordinatesTransformedWith(transform: (Coordinate) -> Coordinate) -> Path
}

extension PathProtocol {
    
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
    
    func withCommandsTransformedWith(transform: (PathCommand) -> PathCommand) -> Path {
    
        return Path(withCommands: commands.map(transform))
    }
    
    func withCommandsCoordinatesTransformedWith(transform: (Coordinate) -> Coordinate) -> Path {
        
        return self.withCommandsTransformedWith { command in
            
            switch command {
            
            case .moveToRelative(let coordinate):
                
                return .moveToRelative(transform(coordinate))
                
            case .lineToRelative(let coordinate):
                
                return .lineToRelative(transform(coordinate))
                
            case .close:
                
                return .close
            }
        }
    }
    
    var flipped: Path { self.withCommandsCoordinatesTransformedWith { $0.flipped } }
    
    var mirrorX: Path { self.withCommandsCoordinatesTransformedWith { $0.mirrorX } }
    
    var mirrorY: Path { self.withCommandsCoordinatesTransformedWith { $0.mirrorY } }
    
    var rotated90DegreesClockWise: Path { self.flipped.mirrorX }
    
    var rotated180DegreesClockWise: Path { self.rotated90DegreesClockWise.rotated90DegreesClockWise }
    
    var rotated270DegreesClockWise: Path { self.rotated180DegreesClockWise.rotated90DegreesClockWise }
}

struct Path: PathProtocol {
    
    init(withCommands commands: [PathCommand]) {
        
        self.commands = commands
    }
    
    let commands: [PathCommand]
}
