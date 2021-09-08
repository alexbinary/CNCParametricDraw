
import Foundation




/// A set of 2D coordinates, composed of an X and Y component.
///
struct Coordinates: Equatable {

    
    /// The X component of the coordinates set.
    ///
    var x: Float
    
    /// The Y component of the coordinates set.
    ///
    var y: Float
    
    
    /// A set of coordinates that has both its X and Y components set to 0.
    ///
    static var zero: Coordinates { Coordinates(x: 0, y: 0) }
    
    
    /// Mutates the components of the set by adding the components of another set.
    ///
    /// The X component of the other set is added to the X component of the set.
    /// The Y component of the other set is added to the Y component of the set.
    ///
    /// - Parameter other: The set whose component should be added to those of the set.
    ///
    mutating func add(_ other: Coordinates) {
        
        self += other
    }
    
    
    /// A set of coordinates whose X component is equal to the Y component of the set and vice-versa.
    ///
    var flipped: Coordinates { Coordinates(x: y, y: x) }
    
    
    /// A set of coordinates whose X component is equal to the opposite of the X component (i.e. -x) of the set and vice-versa.
    ///
    var mirrorX: Coordinates { Coordinates(x: -x, y: y) }
    
    
    /// A set of coordinates whose Y component is equal to the opposite of the Y component (i.e. -x) of the set and vice-versa.
    ///
    var mirrorY: Coordinates { Coordinates(x: x, y: -y) }
}


/// Adds the components of two coordinates sets.
///
/// - Returns A coordinates set whose X and Y components are respectively the sum of the two coordinates' X and Y components.
///
func +(lhs: Coordinates, rhs: Coordinates) -> Coordinates {
    
    return Coordinates(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}


/// Substracts the components of a coordinates set from another coordinates set.
///
/// - Returns A coordinates set whose X and Y components are respectively the difference of the two coordinates' X and Y components.
///
func -(lhs: Coordinates, rhs: Coordinates) -> Coordinates {
    
    return Coordinates(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}


/// Mutates the components of a set by adding the components of another set.
///
/// The X component of the second set is added to the X component of the first set.
/// The Y component of the second set is added to the Y component of the first set.
///
func +=(lhs: inout Coordinates, rhs: Coordinates) {
    
    lhs = lhs + rhs
}



/// Represents a 2D size with a width and height component.
///
struct Size: Equatable {

   
    /// The width component of the size.
    ///
    var width: Float
    
    
    /// The height component  of the size.
    ///
    var height: Float
    
    
    /// A size that has a width and height both set to zero.
    ///
    static var zero: Size { Size(width: 0, height: 0) }
    
    
    /// Creates a size with given width and height.
    ///
    init(width: Float, height: Float) {
        
        self.width = width
        self.height = height
    }
    
    /// Creates a size that measures the distance between two points.
    ///
    init(from point1: Coordinates, to point2: Coordinates) {
        
        self.width = point2.x - point1.x
        self.height = point2.y - point1.y
    }
}



struct CoordinatesBox: Equatable {

    
    var origin: Coordinates
    var size: Size
    
    
    var endPoint: Coordinates {
        
        return Coordinates(x: origin.x + size.width, y: origin.y + size.height)
    }
    
    
    func offsetBy(_ offset: Coordinates) -> CoordinatesBox {
        
        return CoordinatesBox(origin: self.origin + offset, size: size)
    }
}
