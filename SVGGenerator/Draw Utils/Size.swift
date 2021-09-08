
import Foundation



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
