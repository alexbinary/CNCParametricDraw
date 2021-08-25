
import Foundation



struct Coordinate {
    
    let x: Float
    let y: Float
}

enum PathCommand {
    
    case moveTo(Coordinate)
    case lineTo(Coordinate)
    case close
}

struct Path {
    
    let commands: [PathCommand]
}
