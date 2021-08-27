
import Foundation



let outputFileURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent("generated.svg")

func write(_ content: String, to url: URL) {

    try! svgContentString.data(using: .utf8)!.write(to: outputFileURL)
    
    print("written to \(outputFileURL)")
}


let offsetStart: Float = 5
let offsetEnd: Float = 5

let path = Path(withCommands: [
    .lineToRelative(Coordinate(x: 30, y: 0)),
    .lineToRelative(Coordinate(x: -15, y: 15)),
])

let abstractSVGPaths = [
    path.svgPath,
//    path.flipped.svgPath,
//    path.mirrorX.svgPath,
//    path.mirrorY.svgPath,
    path.rotated90DegreesClockWise.svgPath,
//    SVGPath(withCommands: [
//        .moveTo(SVGCoordinate(x: offsetStart, y: 0), .relative)
//    ]).appending(CrenelPath(
//        totalLength: 100,
//        numberOfCrenels: 2,
//        crenelConfig: CrenelConfig(
//            baseLength: 2,
//            lengthAdjustment: 0,
//            depth: 1
//        ),
//        direction: .normal,
//        offsetStart: offsetStart,
//        offsetEnd: offsetEnd
//    )),
//    CrenelPath(
//        totalLength: 100,
//        numberOfCrenels: 5,
//        crenelConfig: CrenelConfig(
//            baseLength: 5,
//            lengthAdjustment: 0,
//            depth: 3.15
//        ),
//        direction: .normal,
//        offsetStart: 0,
//        offsetEnd: 0
//    ).svgPath
]

let pathStyle = "fill:none;stroke:#000000;stroke-width:0.2;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"

let nodes = [
    SVGPathNode(
        path: abstractSVGPaths[0].starting(at: SVGCoordinate(x: 0, y: 0)),
        pathStyle: "fill:none;stroke:#000000;stroke-width:0.2;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1",
        nodeId: "n1"
    ),
    SVGPathNode(
        path: abstractSVGPaths[1].starting(at: SVGCoordinate(x: 0, y: 0)),
        pathStyle: "fill:none;stroke:#0000ff;stroke-width:0.2;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1",
        nodeId: "cren1"
    ),
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
