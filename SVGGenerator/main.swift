
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
    ])
]

let nodes = abstractSVGPaths.map {
    SVGPathNode(
        path: $0.resolve(usingAsMainAxis: .horizontal).starting(at: SVGConcreteCoordinate(x: 2, y: 3)),
        pathStyle: "fill:none;stroke:#000000;stroke-width:0.2;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1",
        nodeId: "n1"
    )
}

let svgContentString = SVGFile(
    pathsNodes: nodes
).render()


write(svgContentString, to: outputFileURL)
