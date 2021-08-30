
import Foundation



let outputFileURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent("generated.svg")

func write(_ content: String, to url: URL) {

    try! svgContentString.data(using: .utf8)!.write(to: outputFileURL)
    
    print("written to \(outputFileURL)")
}



let pathStyle = "fill:none;stroke:#000000;stroke-width:0.2;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"

let nodes = [
    SVGPathNode(
        path: BoxFace(
            size: Size(width: 100, height: 100),
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
//    SVGPathNode(
//        path: abstractSVGPaths[1].starting(at: SVGCoordinate(x: 0, y: 0)),
//        pathStyle: "fill:none;stroke:#0000ff;stroke-width:0.2;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1",
//        nodeId: "cren1"
//    ),
//    SVGPathNode(
//        path: abstractSVGPaths[2].starting(at: SVGCoordinate(x: 0, y: 0)),
//        pathStyle: "fill:none;stroke:#00ff00;stroke-width:0.2;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1",
//        nodeId: "cren2"
//    ),
//    SVGPathNode(
//        path: abstractSVGPaths[3].starting(at: SVGCoordinate(x: 0, y: 0)),
//        pathStyle: "fill:none;stroke:#ff0000;stroke-width:0.2;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1",
//        nodeId: "cren2"
//    ),
]

let svgContentString = SVGFile(
    pathsNodes: nodes
).render()


write(svgContentString, to: outputFileURL)
