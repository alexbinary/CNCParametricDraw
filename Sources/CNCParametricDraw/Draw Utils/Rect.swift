
import Foundation



/// Represents a rectangle in a coordinates space.
///
/// A rectangle is defined by a point (called origin) and a size.
///
struct Rect: Equatable {

    
    /// The rectangle's origin.
    ///
    var origin: Coordinates
    
    /// The rectangle's size.
    ///
    var size: Size
    
    
    /// The point that is the result of the addition of the rectangle's origin and its size.
    ///
    /// In a top-left coordinates space, the rectangle's end point is its bottom-right corner.
    ///
    var endPoint: Coordinates {
        
        return Coordinates(x: origin.x + size.width, y: origin.y + size.height)
    }
    
    
    /// Returns a rectangle with same size but whose origin is moved by the given offset.
    ///
    /// - Parameter offset: An offset the rectangle's x origin should be moved by.
    ///
    /// - Returns: A rectangle with same size but with the origin moved by the given offset.
    ///
    func offsetBy(_ offset: Coordinates) -> Rect {
        
        return Rect(origin: self.origin + offset, size: size)
    }
}
