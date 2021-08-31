
import Foundation



struct Coordinates: Equatable {

    
    var x: Float
    var y: Float
    
    
    static var zero: Coordinates { Coordinates(x: 0, y: 0) }
    
    
    mutating func add(_ other: Coordinates) {
        
        self = Coordinates(x: x + other.x, y: y + other.y)
    }
    
    
    var flipped: Coordinates { Coordinates(x: y, y: x) }
    
    var mirrorX: Coordinates { Coordinates(x: -x, y: y) }
    
    var mirrorY: Coordinates { Coordinates(x: x, y: -y) }
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
