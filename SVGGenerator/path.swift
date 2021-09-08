
import Foundation




struct Path {
    
    
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
    
    
    func enumerateCoordinates(block: (Point) -> Void) {
        
        var currentCoordinate = Point(x: 0, y: 0)
        var firstShapePoint: Point? = nil
        
        block(currentCoordinate)
        
        commands.forEach { command in
            
            switch command {
            
            case .moveBy(let coordinate):
                
                currentCoordinate.add(coordinate)
                
            case .lineByMovingBy(let coordinate):
                
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
    
    
    var endPoint: Point {
    
        var currentCoordinate = Point(x: 0, y: 0)
        
        enumerateCoordinates { coordinate in
            
            currentCoordinate = coordinate
        }
        
        return currentCoordinate
    }
    
    
    var boundingBox: Rect {
        
        var smallestCoordinate: Point! = nil
        var biggestCoordinate: Point! = nil
        
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
        
        let origin: Point! = smallestCoordinate.x < 0 || smallestCoordinate.y < 0 ? smallestCoordinate : Point(x: 0, y: 0)
        let size = Size(width: biggestCoordinate.x - origin.x, height: biggestCoordinate.y - origin.y)
        
        return Rect(origin: origin, size: size)
    }
    
    
    mutating func transformCommandsWith(transform: (PathCommand) -> PathCommand) {
    
        commands = commands.map(transform)
    }
    
    
    mutating func transformCommandsCoordinatesWith(transform: (Point) -> Point) {
        
        transformCommandsWith { command in
            
            switch command {
            
            case .moveBy(let coordinate):
                
                return .moveBy(transform(coordinate))
                
            case .lineByMovingBy(let coordinate):
                
                return .lineByMovingBy(transform(coordinate))
                
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



protocol PathRepresentable {
    
    
    var path: Path { get }
    
    func path(withName: String) -> Path
}


extension PathRepresentable {
    
    
    func path(withName name: String) -> Path {
    
        return Path(fromPath: path, withName: name)
    }
}



enum PathsLayoutItem {
    
    
    case path(Path)
    case layout(PathsLayout)
    
    
    var boundingBox: Rect {
        
        switch self {
        
        case .path(let path):
            return path.boundingBox
            
        case .layout(let layout):
            return layout.boundingBox
        }
    }
}



typealias PathsLayoutElement = (item: PathsLayoutItem, position: Point)


struct PathsLayout {
    
    
    var elements: [PathsLayoutElement]
    
    
    init(withVerticallyAlignedItems items: [PathsLayoutItem]) {
        
        var currentPosition: Point = .zero
        
        self.elements = items.reduce(into: []) { elements, item in
            
            elements.append((item: item, position: currentPosition - item.boundingBox.origin))
            
            currentPosition += Point(x: 0, y: item.boundingBox.size.height)
        }
    }
    
    
    init(withVerticallyAlignedPaths paths: [Path]) {
        
        self.init(withVerticallyAlignedItems: paths.map { .path($0) })
    }
    
    
    init(withVerticallyAlignedLayouts layouts: [PathsLayout]) {
        
        self.init(withVerticallyAlignedItems: layouts.map { .layout($0) })
    }
    
    
    var boundingBox: Rect {
     
        var smallestOrigin: Point! = nil
        var biggestEndPoint: Point! = nil
        
        elements.forEach { (item, position) in
            
            let adjustedBoundingBox = item.boundingBox.offsetBy(position)
            
            if smallestOrigin == nil {
                smallestOrigin = adjustedBoundingBox.origin
            }
            if biggestEndPoint == nil {
                biggestEndPoint = adjustedBoundingBox.endPoint
            }
            
            if adjustedBoundingBox.origin.x < smallestOrigin.x || adjustedBoundingBox.origin.y < smallestOrigin.y {
                smallestOrigin = adjustedBoundingBox.origin
            }
            if adjustedBoundingBox.endPoint.x > biggestEndPoint.x || adjustedBoundingBox.endPoint.y > biggestEndPoint.y {
                biggestEndPoint = adjustedBoundingBox.endPoint
            }
        }
        
        let origin = smallestOrigin!
        let endPoint = biggestEndPoint!
        let size = Size(from: origin, to: endPoint)
        
        return Rect(origin: origin, size: size)
    }
}



protocol PathsLayoutRepresentable {
    
    
    var pathsLayout: PathsLayout { get }
}
