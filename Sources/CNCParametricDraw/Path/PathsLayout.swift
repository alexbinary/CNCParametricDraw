
import Foundation



typealias PathsLayoutElement = (item: PathsLayoutItem, position: Coordinates)


public struct PathsLayout {
    
    
    var elements: [PathsLayoutElement]
    
    
    public init(withVerticallyAlignedItems items: [PathsLayoutItem]) {
        
        var currentPosition: Coordinates = .zero
        
        self.elements = items.reduce(into: []) { elements, item in
            
            elements.append((item: item, position: currentPosition - item.boundingBox.origin))
            
            currentPosition += Coordinates(x: 0, y: item.boundingBox.size.height)
        }
    }
    
    
    public init(withVerticallyAlignedPaths paths: [Path]) {
        
        self.init(withVerticallyAlignedItems: paths.map { .path($0) })
    }
    
    
    public init(withVerticallyAlignedLayouts layouts: [PathsLayout]) {
        
        self.init(withVerticallyAlignedItems: layouts.map { .layout($0) })
    }
    
    
    var boundingBox: Rect {
     
        var smallestOrigin: Coordinates! = nil
        var biggestEndPoint: Coordinates! = nil
        
        elements.forEach { (item, position) in
            
            let adjustedBoundingBox = item.boundingBox.offsetBy(position)
            
            if smallestOrigin == nil {
                smallestOrigin = adjustedBoundingBox.origin
            }
            if biggestEndPoint == nil {
                biggestEndPoint = adjustedBoundingBox.endPoint
            }
            
            if adjustedBoundingBox.origin.x < smallestOrigin.x || adjustedBoundingBox.origin.y < smallestOrigin.y {
                smallestOrigin = adjustedBoundingBox.origin
            }
            if adjustedBoundingBox.endPoint.x > biggestEndPoint.x || adjustedBoundingBox.endPoint.y > biggestEndPoint.y {
                biggestEndPoint = adjustedBoundingBox.endPoint
            }
        }
        
        let origin = smallestOrigin!
        let endPoint = biggestEndPoint!
        let size = Size(from: origin, to: endPoint)
        
        return Rect(origin: origin, size: size)
    }
}
