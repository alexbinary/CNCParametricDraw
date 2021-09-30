
import Foundation



public struct Path {
    
    
    var commands: [PathCommand]
    
    var name: String
    
    
    init(withCommands commands: [PathCommand], name: String? = nil) {
        
        self.commands = commands
        self.name = name ?? ""
    }
    
    
    init(fromPath path: Path, withName name: String? = nil) {
        
        self.init(withCommands: path.commands, name: name)
    }
    
    
    static var empty: Path { Path(withCommands: [], name: "") }
    
    
    var copy: Path { Path(fromPath: self) }
    
    
    mutating func append(_ command: PathCommand) {
        
        commands.append(command)
    }
    
    
    mutating func append(_ path: Path) {
        
        commands.append(contentsOf: path.commands)
    }
    
    
    func enumerateCoordinates(block: (Coordinates) -> Void) {
        
        var currentPoint = Coordinates(x: 0, y: 0)
        var firstShapePoint: Coordinates? = nil
        
        block(currentPoint)
        
        commands.forEach { command in
            
            switch command {
            
            case .moveToRelative(let coordinates):
                
                currentPoint += coordinates
                
            case .lineToRelative(let coordinates):
                
                if firstShapePoint == nil {
                    firstShapePoint = currentPoint
                }
                currentPoint += coordinates
                
            case .close:
                
                currentPoint = firstShapePoint!
            }
            
            block(currentPoint)
        }
    }
    
    
    var endPoint: Coordinates {
    
        var currentCoordinate = Coordinates(x: 0, y: 0)
        
        enumerateCoordinates { coordinate in
            
            currentCoordinate = coordinate
        }
        
        return currentCoordinate
    }
    
    
    var boundingBox: Rect {
        
        var smallestCoordinate: Coordinates! = nil
        var biggestCoordinate: Coordinates! = nil
        
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
        
        let origin: Coordinates! = smallestCoordinate.x < 0 || smallestCoordinate.y < 0 ? smallestCoordinate : Coordinates(x: 0, y: 0)
        let size = Size(width: biggestCoordinate.x - origin.x, height: biggestCoordinate.y - origin.y)
        
        return Rect(origin: origin, size: size)
    }
    
    
    mutating func transformCommandsWith(transform: (PathCommand) -> PathCommand) {
    
        commands = commands.map(transform)
    }
    
    
    mutating func transformCommandsCoordinatesWith(transform: (Coordinates) -> Coordinates) {
        
        transformCommandsWith { command in
            
            switch command {
            
            case .moveToRelative(let coordinates):
                
                return .moveToRelative(transform(coordinates))
                
            case .lineToRelative(let coordinates):
                
                return .lineToRelative(transform(coordinates))
                
            case .close:
                
                return .close
            }
        }
    }
    
    
    mutating func flip() {
        
        self.transformCommandsCoordinatesWith { $0.flipped }
    }
    
    
    var flipped: Path {
        
        var path = Path(fromPath: self)
        path.flip()
        return path
    }
    
    
    mutating func mirrorX() {
        
        self.transformCommandsCoordinatesWith { $0.mirrorX }
    }
    
    
    mutating func mirrorY() {
        
        self.transformCommandsCoordinatesWith { $0.mirrorY }
    }
    
    
    var transformedMirrorX: Path {
        
        var path = Path(fromPath: self)
        path.mirrorX()
        return path
    }
    
    
    var transformedMirrorY: Path {
        
        var path = Path(fromPath: self)
        path.mirrorY()
        return path
    }
    
    
    var rotated90DegreesClockWise: Path { self.flipped.transformedMirrorX }
    var rotated180DegreesClockWise: Path { self.rotated90DegreesClockWise.rotated90DegreesClockWise }
    var rotated270DegreesClockWise: Path { self.rotated180DegreesClockWise.rotated90DegreesClockWise }
}
