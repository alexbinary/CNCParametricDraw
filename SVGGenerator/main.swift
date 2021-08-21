
import Foundation



let outputFileURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent("generated.svg")

func write(_ content: String, to url: URL) {

    try! svgContentString.data(using: .utf8)!.write(to: outputFileURL)
    
    print("written to \(outputFileURL)")
}



let abstractSVGPaths = [
    SVGAbstractPath(components: [
        .move(SVGAbstractCoordinate(mainAxisValue: 10, secondaryAxisValue: 20), .relative),
        .line(SVGAbstractCoordinate(mainAxisValue: 30, secondaryAxisValue: 40), .relative),
        .axis(.main, 50, .relative),
        .axis(.secondary, 60, .relative),
        .close,
        .move(SVGAbstractCoordinate(mainAxisValue: 100, secondaryAxisValue: 0), .absolute),
        .axis(.secondary, 50, .relative),
    ]),
    CrenelMove(
        totalLength: 100,
        numberOfCrenels: 2,
        crenelConfig: CrenelConfig(
            baseLength: 2,
            lengthAdjustment: 0,
            depth: 1
        ),
        direction: .normal,
        offsetStart: 0,
        offsetEnd: 0
    ).makePath(),
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
        path: abstractSVGPaths[0].resolve(usingAsMainAxis: .horizontal).starting(at: SVGConcreteCoordinate(x: 2, y: 3)),
        pathStyle: pathStyle,
        nodeId: "n1"
    ),
    SVGPathNode(
        path: abstractSVGPaths[1].resolve(usingAsMainAxis: .horizontal).starting(at: SVGConcreteCoordinate(x: 0, y: 30)),
        pathStyle: pathStyle,
        nodeId: "cren1"
    ),
    SVGPathNode(
        path: abstractSVGPaths[2].resolve(usingAsMainAxis: .horizontal).starting(at: SVGConcreteCoordinate(x: 0, y: 40)),
        pathStyle: pathStyle,
        nodeId: "cren2"
    )
]

let svgContentString = SVGFile(
    pathsNodes: nodes
).render()


write(svgContentString, to: outputFileURL)
