
import Foundation



/// The elementary component of a path.
///
enum PathCommand {

   
    /// Instructs a move of the drawing head without actually drawing something by the given X and Y components relative to the current position.
    ///
    case moveToRelative(Coordinates)
    
    
    /// Instructs the drawing of the a line between the current position and the current position offset by the given X and Y components.
    ///
    case lineToRelative(Coordinates)
    
    
    /// Instructs to close the path, i.e. draw a line from the current position to the starting point of the first line in the path.
    ///
    case close
}
