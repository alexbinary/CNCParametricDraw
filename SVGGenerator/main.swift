
import Foundation



let outputFileURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent("generated.svg")

func write(_ content: String, to url: URL) {

    try! svgContentString.data(using: .utf8)!.write(to: outputFileURL)
    
    print("written to \(outputFileURL)")
}


let offsetStart: Float = 5
let offsetEnd: Float = 5

let abstractSVGPaths = [
    SVGPath(commands: [
        .moveTo(SVGCoordinate(x: 10, y: 20), .relative),
        .lineTo(SVGCoordinate(x: 30, y: 40), .relative),
        .axis(.horizontal, 50, .relative),
        .axis(.vertical, 60, .relative),
        .close,
        .moveTo(SVGCoordinate(x: 100, y: 0), .absolute),
        .axis(.vertical, 50, .relative),
    ]),
    SVGPath(commands: [
        .moveTo(SVGCoordinate(x: offsetStart, y: 0), .relative)
    ]).appending(CrenelMove(
        totalLength: 100,
        numberOfCrenels: 2,
        crenelConfig: CrenelConfig(
            baseLength: 2,
            lengthAdjustment: 0,
            depth: 1
        ),
        direction: .normal,
        offsetStart: offsetStart,
        offsetEnd: offsetEnd
    ).makePath().commands),
    CrenelMove(
        totalLength: 100,
        numberOfCrenels: 5,
        crenelConfig: CrenelConfig(
            baseLength: 5,
            lengthAdjustment: 0,
            depth: 3.15
        ),
        direction: .normal,
        offsetStart: 0,
        offsetEnd: 0
    ).makePath()
]

let pathStyle = "fill:none;stroke:#000000;stroke-width:0.2;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"

let nodes = [
    SVGPathNode(
        path: abstractSVGPaths[0].starting(at: SVGCoordinate(x: 2, y: 3)),
        pathStyle: pathStyle,
        nodeId: "n1"
    ),
    SVGPathNode(
        path: abstractSVGPaths[1].starting(at: SVGCoordinate(x: 0, y: 30)),
        pathStyle: pathStyle,
        nodeId: "cren1"
    ),
    SVGPathNode(
        path: abstractSVGPaths[2].starting(at: SVGCoordinate(x: 0, y: 40)),
        pathStyle: pathStyle,
        nodeId: "cren2"
    )
]

let svgContentString = SVGFile(
    pathsNodes: nodes
).render()


write(svgContentString, to: outputFileURL)
