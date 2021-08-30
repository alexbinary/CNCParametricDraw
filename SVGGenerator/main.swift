
import Foundation



let outputFileURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent("generated.svg")

let defaultPathStyle = "fill:none;stroke:#000000;stroke-width:0.2;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"

let nodes = [
    SVGPathNode(
        path: BoxFace(
            size: BoxFaceSize(width: 100, height: 100),
            leftCrenelConfig: BoxCrenelConfig(
                direction: .external,
                crenelConfig: CrenelConfig(
                    baseLength: 5,
                    lengthAdjustment: 0,
                    depth: 3
                ),
                numberOfCrenels: 5
            ),
            rightCrenelConfig: BoxCrenelConfig(
                direction: .internal,
                crenelConfig: CrenelConfig(
                    baseLength: 5,
                    lengthAdjustment: 0,
                    depth: 3
                ),
                numberOfCrenels: 5
            ),
            topCrenelConfig: nil,
            bottomCrenelConfig: BoxCrenelConfig(
                direction: .external,
                crenelConfig: CrenelConfig(
                    baseLength: 5,
                    lengthAdjustment: 0,
                    depth: 3
                ),
                numberOfCrenels: 5
            )
        ).svgPath,
        pathStyle: "fill:none;stroke:#000000;stroke-width:0.2;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1",
        nodeId: "n1"
    ),
]


write(SVGFile(pathNodes: nodes).render(), to: outputFileURL)
