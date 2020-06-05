//: [Previous](@previous) / [Next](@next)
//: # Introduction
//:
//: This is a playground that will let you draw shapes and other graphics easily.
/*:
 ## Canvas size
 
 Set the size of your desired canvas by adjusting the constants on lines 10 and 11.
 */
let preferredWidth = 500
let preferredHeight = 500
/*:
 ## Required code
 
 Lines 19 to 27 are required to make the playground run.
 
 Please do not remove.
 */
/*// This comments out everything
import Cocoa
import PlaygroundSupport
import CanvasGraphics

// Create canvas
var canvas = Canvas(width: preferredWidth, height: preferredHeight)
var coniferousTree: LindenmayerSystem

// Show the canvas in the playground's live view
PlaygroundPage.current.liveView = canvas
/*:
 ## Add your code
 
 Beginning on line 38, write a meaningful comment.
 
 You can remove the code on line 39 and begin writing your own code.
 
 [Documentation](http://russellgordon.ca/CanvasGraphics/Documentation/) is available.
 */

// Replace this comment with your first comment – what is the goal of the code you're about to write?

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
                                       //
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
        let currentSaturation = 100.0 - Float(y - 300) / 2
        // DEBUG: Uncomment line below to see how this value changes
        print("currentSaturation is: \(currentSaturation)")
        canvas.lineColor = Color(hue: 200.0, saturation: currentSaturation, brightness: 90.0, alpha: 100.0)
        
        // Draw a horizontal line at this vertical location
        canvas.drawLine(from: Point(x: 0, y: y), to: Point(x: canvas.width, y: y))
        
    }
    
    // Create a gradient ground background, brown to darker brown as vertical location increases
    // NOTE: Can use the HSV/HSB sliders (third from top) at this site for help picking colours:
    //       http://colorizer.org
    for y in 0...300 {
        
        // Set the line brightness to progressively get closer to black
        let currentBrightness = 50.0 - Float(y) / 30.0 * 3.0
        // DEBUG: Uncomment line below to see how this value changes
        print("currentBrightness is \(currentBrightness)")
        canvas.lineColor = Color(hue: 25.0, saturation: 68.0, brightness: currentBrightness, alpha: 100.0)
        
        // Draw a horizontal line at this vertical location
        canvas.drawLine(from: Point(x: 0, y: y), to: Point(x: canvas.width, y: y))
        
    }
    
    // Create 9 trees, drawn from their tops along a quadratic path
    
    // Define the vertex of the parabolic path (top right of canvas)
    let vertex = Point(x: 450, y: 350)
    
    // Define some other point on the parabolic path (in this case, closer to bottom left)
    let anotherPointOnParabola = Point(x: 100, y: 225)
    
    // Work out the "a" value for the parabola (vertical stretch)
    let a = (anotherPointOnParabola.y - vertex.y) / pow(anotherPointOnParabola.x - vertex.x, 2)
    
    // Iterate to create 9 trees
    for i in 1...9 {

        // Use a quadratic relationship to define the vertical starting point for the top of each tree
        // (trees grow down from starting point)
        let x = CGFloat(i - 1) * 50.0 + 75              // This defines "spread" of the trees along the quadratic path
        let y = a * pow(x - vertex.x, 2) + vertex.y     // Determine vertical position using y = a(x-h)^2 + k
        
        // DEBUG: To help see where starting points are
        print("Starting point for tree is... x: \(x), y: \(y)")
        
        // Define the length of the tree's initial stroke
        let length = 27.0 - Double(y) / 16.0            // Piggyback on quadratic change in y values to set length
        print("Length of line for system is: \(length)")
        
        // Generate the tree
        var aTree = VisualizedLindenmayerSystem(system: coniferousTree,
                                                length: length,
                                                initialDirection: 270,
                                                reduction: 1.25,
                                                pointToStartRenderingFrom: Point(x: x, y: y),
                                                drawnOn: canvas)
        
        // Render this tree
        aTree.renderFullSystem()
        
    }
    
//canvas.drawRectangle(at: Point(x: 50, y: 75), width: 100, height: 100)

/*:
 ## Show the Assistant Editor
 Don't see any results?
 
 Remember to show the Assistant Editor (1), and then switch to Live View (2):
 
 ![timeline](timeline.png "Timeline")

 ## Use source control
 To keep your work organized, receive feedback, and earn a high grade in this course, regular use of source control is a must.
 
 Please commit and push your work often.
 
 ![source_control](source-control.png "Source Control")
 */
