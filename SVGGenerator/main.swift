
import Foundation



let outputFileURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent("generated.svg")



let legoUnitLength = 15.mm
let materialThickness = 3.mm
let defaultMargin = 5.mm

let standardCrenelConfig = CrenelConfig(
    baseLength: 5.mm,
    lengthAdjustment: 0.mm,
    depth: 3.mm
)


let cabinet = LegoCabinet(
    
    legoUnitLength: legoUnitLength,
    materialThickness: materialThickness,
    
    margin: MetricLength(millimeters: 5),
    
    numberOfStudsWidth: 2,
    numberOfStudsDepth: 2,
    
    shelvesNumberOfPlatesHeightsFromBottomToTop: [3, 2, 1],
    
    crenelConfig: standardCrenelConfig
)

let boxH1 = LegoCrenelBox(
    
    legoUnitLength: legoUnitLength,
    
    numberOfStudsWidth: 2,
    numberOfStudsLength: 2,
    numberOfPlatesHeight: 1,
    
    crenelConfig: standardCrenelConfig
)

let boxH2 = LegoCrenelBox(
    
    legoUnitLength: legoUnitLength,
    
    numberOfStudsWidth: 2,
    numberOfStudsLength: 2,
    numberOfPlatesHeight: 2,
    
    crenelConfig: standardCrenelConfig
)


let boxH3 = LegoCrenelBox(
    
    legoUnitLength: legoUnitLength,
    
    numberOfStudsWidth: 2,
    numberOfStudsLength: 2,
    numberOfPlatesHeight: 3,
    
    crenelConfig: standardCrenelConfig
)

let boxCase = LegoCrenelBoxCase(
    
    legoUnitLength: 15.mm,
    materialThickness: 3.mm,
    margin: 5.mm,
    
    width: 2.studs,
    length: 2.studs,
    height: 3.plates,
    
    crenelConfig: standardCrenelConfig
)

let layout = PathsLayout(withVerticallyAlignedLayouts: [
                            
                            cabinet.pathsLayout,
                            boxH1.pathsLayout,
                            boxH2.pathsLayout,
                            boxH3.pathsLayout
])

    
//    [
//    SVGPathNode(
//        path: BoxFace(
//            width: 100,
//            height: 100,
//            leftCrenelConfig: BoxFaceCrenelConfig(
//                crenelConfig: CrenelConfig(
//                    baseLength: 5,
//                    lengthAdjustment: 0,
//                    depth: 3
//                ),
//                numberOfCrenels: 5,
//                direction: .external
//            ),
//            rightCrenelConfig: BoxFaceCrenelConfig(
//                crenelConfig: CrenelConfig(
//                    baseLength: 5,
//                    lengthAdjustment: 0,
//                    depth: 3
//                ),
//                numberOfCrenels: 5,
//                direction: .internal
//            ),
//            topCrenelConfig: nil,
//            bottomCrenelConfig: BoxFaceCrenelConfig(
//                crenelConfig: CrenelConfig(
//                    baseLength: 5,
//                    lengthAdjustment: 0,
//                    depth: 3
//                ),
//                numberOfCrenels: 5,
//                direction: .external
//            )
//        ).svgPath,
//        pathStyle: "fill:none;stroke:#000000;stroke-width:0.2;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1",
//        nodeId: "n1"
//    ),
//]

let renderer = SVGRenderer(defaultPathStyle: "fill:none;stroke:#000000;stroke-width:0.2;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1")
let fileContent = renderer.renderFile(withRootPathsLayout: layout)

write(fileContent, to: outputFileURL)
