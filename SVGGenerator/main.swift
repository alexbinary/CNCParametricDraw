
import Foundation



let outputFileURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent("generated.svg")

let svgContentString = "test2"

func write(_ content: String, to url: URL) {

    try! svgContentString.data(using: .utf8)!.write(to: outputFileURL)
}

//write(svgContentString, to: outputFileURL)
//
//print(outputFileURL)




let svgPath = SVGAbstractPath(components: [
    .move(SVGAbstractCoordinate(mainAxisValue: 10, secondaryAxisValue: 20), .relative),
    .line(SVGAbstractCoordinate(mainAxisValue: 30, secondaryAxisValue: 40), .relative),
    .axis(.main, 50, .relative),
    .axis(.secondary, 60, .relative),
])

print(svgPath.resolve(usingAsMainAxis: .vertical).render())
