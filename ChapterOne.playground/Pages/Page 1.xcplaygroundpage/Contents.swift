/*:
 # THE ANGRY QUEENS
 In this playground, you will learn about a famous algorithm problem💯 **Eight Queens Puzzle♕** through this little game🎮.
 
 By playing this little game👾, you can 📚learn about the details of this puzzle and the algorithms in the eaziest way.
 
 ## What is eight queens puzzle♕?
 The eight queens puzzle♕ is the problem of placing 8 chess queens♕ on an 8×8 chessboardc so that no two queens threaten each other.
 
 
 **In other words, All the queens are angry😡 at each other. They are so mad😡 at each other that if they see another queen♕ at their attack range⛳️, there will be a fight🏹!** So the solution💡 requires no two queens share the same row, column, or diagonal. Otherwise, they'll start to fight.
 
 
  This puzzle is not only a classic chess♙ puzzle, but also an famous algorithm🖥 problem
 
  ![one solution](sample.png)

 There are also 3 queens puzzle, 4 queens puzzle, etc.
 
 ## How do you play ?
 **For the first level, try to place all the queens♕ without causing a fight🏹.**
 
 
 **👇You can change the amount of queens here(3~20)**
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

let scene = FirstScene(size: CGSize(width: 480, height: 640))
var 💃 = 0
//#-end-hidden-code
💃 = /*#-editable-code number of queens♕*/8/*#-end-editable-code*/
//#-hidden-code

if 💃<3{
    scene.iterk = 3
}else if 💃 > 20{
    scene.iterk = 20
}else{
    scene.iterk = 💃
}
scene.scaleMode = .aspectFill

sceneView.presentScene(scene)

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
//#-end-hidden-code
/*:
 **👇proceed to the nect page after you learn enough about the rules**
 */
//: [I understand the rules](@next)
