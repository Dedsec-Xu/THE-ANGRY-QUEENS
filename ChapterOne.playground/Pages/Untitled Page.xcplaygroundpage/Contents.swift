//: [Previous page](@previous)
/*:
 # Let's play a game😎
 
 Put down the missing queens as soon as possible. Putting down a queen will earn you some more time
 
 
 **Explore the game at your own pace.**
 
 **👇You can change the total amount of queens here(4~10).**
 */
//#-hidden-code
import PlaygroundSupport
import SpriteKit
import PlaygroundSupport
import SpriteKit
import Foundation
import UIKit
import GameKit
import ARKit
import SceneKit


let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 480, height: 640))

sceneView.showsFPS = true
sceneView.showsNodeCount = true

let scene = Game(size: CGSize(width: 480, height: 640))
var 👸 = 4
var 🔳 = 4

//#-end-hidden-code
👸 = /*#-editable-code number of queens♕*/8/*#-end-editable-code*/
🔳 = /*#-editable-code number of queens♕*/8/*#-end-editable-code*/
//#-hidden-code


if 👸<4{
    scene.iterk = 3
}else if 👸 > 10{
    scene.iterk = 20
}else{
    scene.iterk = 👸
}

if 🔳<1{
    scene.blank = 1
}else if 🔳 > 👸{
    scene.blank = 👸
}else{
    scene.blank = 🔳
}

scene.scaleMode = .aspectFill

sceneView.presentScene(scene)

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView


//#-end-hidden-code
/*:
 # Result: This is way faster!
 
 After implementing the backtracking↩️ algorithm. The improvement on speed is significant. You can try different 👸 values to see clearly how the algorithm works.
 
 
 ![solves](solves.jpg)
 
 
 The backtracking↩️ algorithm is a classic algorithm that is used in multiple problems, such as The ♘Knight’s tour problem, m 🌈Coloring Problem and Sudoku Problem. This playground should give you a more straight forward impression on the algorithm.
 
 
 ![Sudoku](Sudoku.gif)
 
 
 Time for a little game👾.
 
 **👇Little game👾**
 */
//: [Another approach](@next)
