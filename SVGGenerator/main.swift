
import Foundation



let outputFileURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent("generated.svg")

func write(_ content: String, to url: URL) {

    try! svgContentString.data(using: .utf8)!.write(to: outputFileURL)
    
    print("written to \(outputFileURL)")
}



let svgPath = SVGAbstractPath(components: [
    .move(SVGAbstractCoordinate(mainAxisValue: 10, secondaryAxisValue: 20), .relative),
    .line(SVGAbstractCoordinate(mainAxisValue: 30, secondaryAxisValue: 40), .relative),
    .axis(.main, 50, .relative),
    .axis(.secondary, 60, .relative),
])

let svgContentString = SVGFile(
    pathsNodes: [
        SVGPathNode(
            path: svgPath.resolve(usingAsMainAxis: .vertical),
            pathStyle: "fill:none;stroke:#000000;stroke-width:0.2;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1",
            nodeId: "n1"
        )
    ]
).render()


write(svgContentString, to: outputFileURL)
