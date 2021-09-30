
import Foundation



enum SVGPathCommand {

    
    case moveTo(Coordinates, SVGCoordinateRef)
    case lineTo(Coordinates, SVGCoordinateRef)
    case axis(SVGAxis, Float, SVGCoordinateRef)
    case close
    
    
    func render() -> String {
        
        switch self {
        
        case .moveTo(let coordinate, let coordinateRef):
            
            return "\(coordinateRef == .absolute ? "M" : "m")\(coordinate.render())"
            
        case .lineTo(let coordinate, let coordinateRef):
            
            return "\(coordinateRef == .absolute ? "L" : "l")\(coordinate.render())"
            
        case .axis(let axis, let value, let coordinateRef):
            
            let opCode = axis == .horizontal ? "h" : "v"
            return "\(coordinateRef == .absolute ? opCode.uppercased() : opCode)\(value)"
            
        case .close:
            
            return "Z"
        }
    }
}
