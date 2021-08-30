
import Foundation



let outputFileURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent("generated.svg")

let box = Box(
    
    width: 100,
    height: 100,
    length: 100,
    
    widthCrenelConfig: BoxCrenelConfig(
        crenelConfig: CrenelConfig(
            baseLength: 5,
            lengthAdjustment: 0,
            depth: 3
        ),
        numberOfCrenels: 5
    ),
    heightCrenelConfig: BoxCrenelConfig(
        crenelConfig: CrenelConfig(
            baseLength: 5,
            lengthAdjustment: 0,
            depth: 3
        ),
        numberOfCrenels: 5
    ),
    lengthCrenelConfig: BoxCrenelConfig(
        crenelConfig: CrenelConfig(
            baseLength: 5,
            lengthAdjustment: 0,
            depth: 3
        ),
        numberOfCrenels: 5
    )
)



let paths = box.paths
    
//    [
//    SVGPathNode(
//        path: BoxFace(
//            width: 100,
//            height: 100,
//            leftCrenelConfig: BoxFaceCrenelConfig(
//                crenelConfig: CrenelConfig(
//                    baseLength: 5,
//                    lengthAdjustment: 0,
//                    depth: 3
//                ),
//                numberOfCrenels: 5,
//                direction: .external
//            ),
//            rightCrenelConfig: BoxFaceCrenelConfig(
//                crenelConfig: CrenelConfig(
//                    baseLength: 5,
//                    lengthAdjustment: 0,
//                    depth: 3
//                ),
//                numberOfCrenels: 5,
//                direction: .internal
//            ),
//            topCrenelConfig: nil,
//            bottomCrenelConfig: BoxFaceCrenelConfig(
//                crenelConfig: CrenelConfig(
//                    baseLength: 5,
//                    lengthAdjustment: 0,
//                    depth: 3
//                ),
//                numberOfCrenels: 5,
//                direction: .external
//            )
//        ).svgPath,
//        pathStyle: "fill:none;stroke:#000000;stroke-width:0.2;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1",
//        nodeId: "n1"
//    ),
//]

let renderer = SVGRenderer(defaultPathStyle: "fill:none;stroke:#000000;stroke-width:0.2;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1")
let fileContent = renderer.renderFile(withPaths: paths)

write(fileContent, to: outputFileURL)
