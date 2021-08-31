
import Foundation



struct Coordinates: Equatable {

    
    var x: Float
    var y: Float
    
    
    static var zero: Coordinates { Coordinates(x: 0, y: 0) }
    
    
    mutating func add(_ other: Coordinates) {
        
        self += other
    }
    
    
    var flipped: Coordinates { Coordinates(x: y, y: x) }
    
    var mirrorX: Coordinates { Coordinates(x: -x, y: y) }
    
    var mirrorY: Coordinates { Coordinates(x: x, y: -y) }
}


func +(lhs: Coordinates, rhs: Coordinates) -> Coordinates {
    
    return Coordinates(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}


func -(lhs: Coordinates, rhs: Coordinates) -> Coordinates {
    
    return Coordinates(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}


func +=(lhs: inout Coordinates, rhs: Coordinates) {
    
    lhs = lhs + rhs
}




struct Size: Equatable {

    
    var width: Float
    var height: Float
    
    
    static var zero: Size { Size(width: 0, height: 0) }
}



struct CoordinatesBox: Equatable {

    
    var origin: Coordinates
    var size: Size
}
