import Foundation
import CanvasGraphics

public class Sketch : NSObject {
    
    // NOTE: Every sketch must contain an object of type Canvas named 'canvas'
    //       Therefore, the line immediately below must always be present.
    let canvas: Canvas
    
    // L-system definitions
    let coniferousTree: LindenmayerSystem
    let somewhatCloud: LindenmayerSystem
    let somewhatSun: LindenmayerSystem
    let flower: LindenmayerSystem
    
    // This function runs once
    override init() {
        
        // Create canvas object – specify size
        canvas = Canvas(width: 500, height: 500)
        
        // Draw slowly
        //canvas.framesPerSecond = 1
        
        //Define A Turquoise and Purple flower like L-System (not mine, author: Puneet Bagga)
        flower = LindenmayerSystem(axiom: "SF-F-F-F-F-F",
                                   angle: 300,
                                   rules: ["F" : [
                                    RuleSet(odds: 1, successorText: "1F-2X++1F+2F-1X+2F")
                                    ],
                                           "X" : [
                                            RuleSet(odds: 1, successorText: "1F-2X+1F++2X+1F+2X")
                                    ]
                                    ],
                                   colors: ["1": Color(hue: 288, saturation: 80, brightness: 36, alpha: 100),
                                            "2": Color(hue: 174, saturation: 71, brightness: 88, alpha: 100),
                                            ],
                                   generations: 5)
        
        //Define an L-System that somewhat resembles a Sun (Basically changing the cloud system)
        somewhatSun = LindenmayerSystem(axiom: "SF+F+F+F+F+F+F+F+",
                                        angle: 45,
                                        rules: ["F" : [RuleSet(odds: 1, successorText: "1+F--F+F")]],
                                        colors: ["1": Color(hue: 50, saturation: 80, brightness: 100, alpha: 100)],
                                        generations: 6)
        
        // Define an L-System that somewhat resembles a cloud (Basically an octogan)
        somewhatCloud = LindenmayerSystem(axiom: "SF+F+F+F+F+F+F+F+",
                                          angle: 45,
                                          rules: ["F" : [
                                            RuleSet(odds: 1, successorText: "1F+F--F+F"),
                                            //RuleSet(odds: 1, successorText: "1+F--F+F"),
                                            //RuleSet(odds: 1, successorText: "1F+F--+F")
                                            ]],
                                          colors: ["1": Color(hue: 360, saturation: 0, brightness: 100, alpha: 100)],
                                          generations: 6)
        
        // Define a stochastic system that resembles a coniferous tree
        coniferousTree = LindenmayerSystem(axiom: "SF",
                                           angle: 20,
                                           rules: ["F": [
                                                        RuleSet(odds: 1, successorText: "3F[++1F[X]][+2F][-4F][--5F[X]]6F"),
                                                        RuleSet(odds: 1, successorText: "3F[+1F][+2F][-4F]5F"),
                                                        RuleSet(odds: 1, successorText: "3F[+1F][-2F][--6F]4F"),
                                                        ],
                                                   "X": [
                                                        RuleSet(odds: 1, successorText: "X")
                                                        ]
                                                  ],
                                           colors: ["1": Color(hue: 120, saturation: 100, brightness: 61, alpha: 100),
                                                    "2": Color(hue: 134, saturation: 97, brightness: 46, alpha: 100),
                                                    "3": Color(hue: 145, saturation: 87, brightness: 8, alpha: 100),
                                                    "4": Color(hue: 135, saturation: 84, brightness: 41, alpha: 100),
                                                    "5": Color(hue: 116, saturation: 26, brightness: 100, alpha: 100),
                                                    "6": Color(hue: 161, saturation: 71, brightness: 53, alpha: 100)
                                                   ],
                                           generations: 5)
        
        // Create a gradient sky background, blue to white as vertical location increases
        for y in 300...500 {
            
            // Set the line saturation to progressively get closer to white
            let currentSaturation = 100.0 + Float(y + 300) / 2
            // DEBUG: Uncomment line below to see how this value changes
            //print("currentSaturation is: \(currentSaturation)")
            canvas.lineColor = Color(hue: 200.0, saturation: currentSaturation, brightness: 90.0, alpha: 100.0)
            
            // Draw a horizontal line at this vertical location
            canvas.drawLine(from: Point(x: 0, y: y), to: Point(x: canvas.width, y: y))
            
        }
        
        //Create green ground which fades to black
        for y in 0...300 {
            
            // Set the line brightness to progressively get closer to black
            let currentBrightness = 68.83 - Float(y) / 5
            // DEBUG: Uncomment line below to see how this value changes
            //print("currentBrightness is \(currentBrightness)")
            canvas.lineColor = Color(hue: 134.4, saturation: 100, brightness: currentBrightness, alpha: 100.0)
            
            // Draw a horizontal line at this vertical location
            canvas.drawLine(from: Point(x: 0, y: y), to: Point(x: canvas.width, y: y))
            
        }
        
        //Create the flower between the row of trees
        for x in 1...3 {
            for y in 1...3 {
        var purpleFlower = VisualizedLindenmayerSystem(system: flower,
                                                       length: 2,
                                                       initialDirection: 20,
                                                       reduction: 1.5,
                                                       pointToStartRenderingFrom: Point(x: 115 * x, y: 75 * y),
                                                       drawnOn: canvas)
        //Render the flower
        purpleFlower.renderFullSystem()
            }
        }
        
        //Create the sun in the top left corner
        //Generate the somewhatSun
        var sun = VisualizedLindenmayerSystem(system: somewhatSun,
                                              length: 30,
                                              initialDirection: 0,
                                              reduction: 2.5,
                                              pointToStartRenderingFrom: Point(x: 50, y: 550),
                                              drawnOn: canvas)
        //Render the sun
        sun.renderFullSystem()
        
        //Create somewhatClouds in the sky
        //Generate the somehwhatCloud in random positions in the sky
        for _ in 1...15 {
            let x = random(from: 0, to: 500)
            let y = random(from: 350, to: 500)
        var cloud = VisualizedLindenmayerSystem(system: somewhatCloud,
                                                length: 30,
                                                initialDirection: 0,
                                                reduction: 4.6,
                                                pointToStartRenderingFrom: Point(x: x, y: y),
                                                drawnOn: canvas)
        //Render the cloud
        cloud.renderFullSystem()
        }
        
        //Create column of trees (1 of 2)
        // Iterate to create 9 trees
        for i in 1...8 {
            let x = 70
            let y = 40 * i
            
            // DEBUG: To help see where starting points are
           // print("Starting point for tree is... x: \(x), y: \(y)")
            
            // Define the length of the tree's initial stroke
            let length = 27.0 - Double(y) / 16.0
            //print("Length of line for system is: \(length)")
            
            // Generate the tree
            var aTree = VisualizedLindenmayerSystem(system: coniferousTree,
                                                    length: length,
                                                    initialDirection: 270,
                                                    reduction: 1.25,
                                                    pointToStartRenderingFrom: Point(x: x, y: y),
                                                    drawnOn: canvas)
            
            // Render this tree
            aTree.renderFullSystem()
            
            //Create column of trees (2 of 2)
            for height in 1...8 {
                let x = 430
                let y = 40 * height
                // Define the length of the tree's initial stroke
                let length = 27.0 - Double(y) / 16.0
                
                // Generate the tree
                var treeColumn = VisualizedLindenmayerSystem(system: coniferousTree,
                                                             length: length,
                                                             initialDirection: 270,
                                                             reduction: 1.25,
                                                             pointToStartRenderingFrom: Point(x: x, y: y),
                                                             drawnOn: canvas)
                //Render this tree
                treeColumn.renderFullSystem()
            }
            
        }
        
        
    }
    
    // This function runs repeatedly, forever, to create the animated effect
    func draw() {
        
        // Nothing to animate, so nothing in this function
        
    }
    
}
