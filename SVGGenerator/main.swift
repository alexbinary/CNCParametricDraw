
import Foundation



let outputFileURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent("generated.svg")



let legoUnitLength = 15.mm
let materialThickness = 3.mm
let defaultMargin = 5.mm
let crenelBaseLength = 5.mm
let crenelDepth = 3.15.mm
let crenelLengthAdjustmentInternal = -0.75.mm
let crenelLengthAdjustmentExternal = 0.mm

let standardCrenelConfigInternal = CrenelConfig(
    baseLength: crenelBaseLength,
    lengthAdjustment: crenelLengthAdjustmentInternal,
    depth: crenelDepth
)
let standardCrenelConfigExternal = CrenelConfig(
    baseLength: crenelBaseLength,
    lengthAdjustment: crenelLengthAdjustmentExternal,
    depth: crenelDepth
)



var wine_box = CrenelBox(
    
    width: 260.mm,
    length: 330.mm,
    height: 180.mm,
    
    widthCrenelConfig: BoxCrenelConfig(crenelConfigInternal: standardCrenelConfigInternal, crenelConfigExternal: standardCrenelConfigExternal, numberOfCrenels: .manual(25)),
    lengthCrenelConfig: BoxCrenelConfig(crenelConfigInternal: standardCrenelConfigInternal, crenelConfigExternal: standardCrenelConfigExternal, numberOfCrenels: .manual(32)),
    heightCrenelConfig: BoxCrenelConfig(crenelConfigInternal: standardCrenelConfigInternal, crenelConfigExternal: standardCrenelConfigExternal, numberOfCrenels: .manual(17))
)

let layout = PathsLayout(withVerticallyAlignedLayouts: [ wine_box.pathsLayout ])


let renderer = SVGRenderer(defaultPathStyle: "fill:none;stroke:#000000;stroke-width:0.2;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1")
let fileContent = renderer.renderFile(withRootPathsLayout: layout)

write(fileContent, to: outputFileURL)
