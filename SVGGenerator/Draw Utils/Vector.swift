
import Foundation



/// A set of 2D coordinates, composed of an X and Y component.
///
struct Vector: Equatable {

    
    /// The X component of the coordinates set.
    ///
    var x: Float
    
    /// The Y component of the coordinates set.
    ///
    var y: Float
    
    
    /// A vector that has both its X and Y components set to 0.
    ///
    static var zero: Vector { Vector(x: 0, y: 0) }
    
    
    /// Mutates the components of the vector by adding the components of another vector.
    ///
    /// The X component of the other vector is added to the X component of the vector.
    /// The Y component of the other vector is added to the Y component of the vector.
    ///
    /// - Parameter other: The vector whose component should be added to those of the vector.
    ///
    mutating func add(_ other: Vector) {
        
        self += other
    }
    
    
    /// A vector whose X component is equal to the Y component of the vector and vice-versa.
    ///
    var flipped: Vector { Vector(x: y, y: x) }
    
    
    /// A vector whose X component is equal to the opposite of the X component (i.e. -x) of the vector and vice-versa.
    ///
    var mirrorX: Vector { Vector(x: -x, y: y) }
    
    
    /// A vector whose Y component is equal to the opposite of the Y component (i.e. -x) of the vector and vice-versa.
    ///
    var mirrorY: Vector { Vector(x: x, y: -y) }
}



/// Adds the components of two vectors.
///
/// - Returns A vector whose X and Y components are respectively the sum of the two vectors' X and Y components.
///
func +(lhs: Vector, rhs: Vector) -> Vector {
    
    return Vector(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}


/// Substracts the components of a vector from another vector.
///
/// - Returns A vector whose X and Y components are respectively the difference of the two vectors' X and Y components.
///
func -(lhs: Vector, rhs: Vector) -> Vector {
    
    return Vector(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}


/// Mutates the components of a vector by adding the components of another vector.
///
/// The X component of the second vector is added to the X component of the first vector.
/// The Y component of the second vector is added to the Y component of the first vector.
///
func +=(lhs: inout Vector, rhs: Vector) {
    
    lhs = lhs + rhs
}
