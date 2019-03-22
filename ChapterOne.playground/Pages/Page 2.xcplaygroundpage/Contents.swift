//: [Previous](@previous)
/*:
 # How do we solve this puzzle?
 Having gone through the little game👾, we have learnt about the rules. We also know: This is not an easy puzzle. So how do we solve it?
 
 
 How about we try brute force? Brute force is going through all the possible placement and save all answers.
 
 
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

let scene = SecondScene(size: CGSize(width: 480, height: 640))
var 💃 = 0
var 😡 = true

//#-end-hidden-code
💃 = /*#-editable-code number of queens♕*/8/*#-end-editable-code*/

/*:
 **👇LOOP**
 */
if 😡==false{
    //save
}else{
    //ChangeQueenPositio
}

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
//: [Next](@next)
