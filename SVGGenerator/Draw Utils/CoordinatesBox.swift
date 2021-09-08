
import Foundation



/// Represents a box in a coordinates space.
///
/// A box has an origin and a size.
/// By convention, a box always has a positive size, such that in a top-left coordinate space, the box' origin is its the top-left corner.
///
struct CoordinatesBox: Equatable {

    
    /// The box' origin.
    ///
    /// By convention, a box always has a positive size, such that in a top-left coordinate space, the box' origin is its the top-left corner.
    ///
    var origin: Point
    
    /// The box' size.
    ///
    /// By convention, a box always has a positive size, such that in a top-left coordinate space, the box' origin is its the top-left corner.
    ///
    var size: Size
    
    
    /// The box' end point.
    ///
    /// In a top-left coordinates space, the box' end point is its bottom-right corner.
    ///
    var endPoint: Point {
        
        return Point(x: origin.x + size.width, y: origin.y + size.height)
    }
    
    
    /// Returns a box with same size but whose origin is moved by the given offset.
    ///
    /// - Parameter offset: A set of coordinates whose X and Y components that should be added to the box'x origin.
    ///
    /// - Returns: A box with same size but with the origin moved by the given offset.
    ///
    func offsetBy(_ offset: Point) -> CoordinatesBox {
        
        return CoordinatesBox(origin: self.origin + offset, size: size)
    }
}
