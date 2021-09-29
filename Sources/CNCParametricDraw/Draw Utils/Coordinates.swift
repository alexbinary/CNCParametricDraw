
import Foundation



/// A set of 2D coordinates, composed of an X and Y component.
///
struct Coordinates: Equatable {

    
    /// The point's X coordinate.
    ///
    var x: Float
    
    /// The point's Y coordinate.
    ///
    var y: Float
    
    
    /// A point that has both its X and Y coordinates set to 0.
    ///
    static var zero: Coordinates { Coordinates(x: 0, y: 0) }
    
    
//    func offsetting(by offset: Coordinates) -> Coordinates {
//
//        return Point(
//            x: self.x + offset.dx,
//            y: self.y + offset.dy
//        )
//    }
//    
//    
//    
//    mutating func offset(by offset: Offset) {
//
//        self.x += offset.dx
//        self.y += offset.dy
//    }

    
    //    /// Mutates the point's X and Y coordinates respectively by adding the X and Y coordinates of another point.
//    ///
//    /// The X component of the other vector is added to the X component of the vector.
//    /// The Y component of the other vector is added to the Y component of the vector.
//    ///
//    /// - Parameter other: The vector whose component should be added to those of the vector.
//    ///
//    mutating func add(_ other: Point) {
//
//        self += other
//    }
    
    
    /// A vector whose X component is equal to the Y component of the vector and vice-versa.
    ///
    var flipped: Coordinates { Coordinates(x: y, y: x) }


    /// A vector whose X component is equal to the opposite of the X component (i.e. -x) of the vector and vice-versa.
    ///
    var mirrorX: Coordinates { Coordinates(x: -x, y: y) }


    /// A vector whose Y component is equal to the opposite of the Y component (i.e. -x) of the vector and vice-versa.
    ///
    var mirrorY: Coordinates { Coordinates(x: x, y: -y) }
}



/// Adds the components of two vectors.
///
/// - Returns A vector whose X and Y components are respectively the sum of the two vectors' X and Y components.
///
func +(lhs: Coordinates, rhs: Coordinates) -> Coordinates {

    return Coordinates(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}


/// Substracts the components of a vector from another vector.
///
/// - Returns A vector whose X and Y components are respectively the difference of the two vectors' X and Y components.
///
func -(lhs: Coordinates, rhs: Coordinates) -> Coordinates {

    return Coordinates(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}


/// Mutates the components of a vector by adding the components of another vector.
///
/// The X component of the second vector is added to the X component of the first vector.
/// The Y component of the second vector is added to the Y component of the first vector.
///
func +=(lhs: inout Coordinates, rhs: Coordinates) {

    lhs = lhs + rhs
}
