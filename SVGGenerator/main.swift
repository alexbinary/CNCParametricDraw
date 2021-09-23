
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



var box_m15_4x4_h2 = LegoCrenelBox(
    
    legoUnitLength: legoUnitLength,
    
    width: 4.studs,
    length: 4.studs,
    height: 2.plates,
    
    crenelConfigInternal: standardCrenelConfigInternal,
    crenelConfigExternal: standardCrenelConfigExternal
)
box_m15_4x4_h2.numberOfCrenelsWidth = .manual(14)
box_m15_4x4_h2.numberOfCrenelsLength = .manual(14)
box_m15_4x4_h2.numberOfCrenelsHeight = .manual(2)

let layout = PathsLayout(withVerticallyAlignedLayouts: [ box_m15_4x4_h2.pathsLayout ])


let renderer = SVGRenderer(defaultPathStyle: "fill:none;stroke:#000000;stroke-width:0.2;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1")
let fileContent = renderer.renderFile(withRootPathsLayout: layout)

write(fileContent, to: outputFileURL)
