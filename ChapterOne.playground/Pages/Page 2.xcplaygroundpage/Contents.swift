//: [Previous page](@previous)
/*:
 # How do we solve this puzzle?
 Having gone through the little game👾, we have learnt about the rules. We also know: This is not an easy puzzle. So how do we solve it?
 
 
 How about we try brute force? Brute force is going through all the possible placement and save all answers.
 
 
 **👇You can change the amount of queens here(3~20), Let's try small amounts first.**
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
var 🕐 = 100

//#-end-hidden-code
💃 = /*#-editable-code number of queens♕*/4/*#-end-editable-code*/

/*:
 
 **👇You can change the speed of animations by changing the wait time(1~1000ms).**
 
 */

🕐 = /*#-editable-code move speed*/100/*#-end-editable-code*/

/*:
 **This 👇LOOP**
 */
if 😡==false{
    //save
}else{
    //wait for 🕐 ms
    //ChangeQueenPosition
}

//#-hidden-code

if 🕐<1{
    scene.waitt = 1
}else if 🕐 > 1000{
    scene.waitt = 1000
}else{
    scene.waitt = 🕐
}

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
 # This is going to take forever!
 
 It seems that brute force is too slow🐢 when 💃 is too big!
 
 
 Let's do a small calculation:
 n queens problem have n^2Cn possible solves. so it takes 64C8 loops, which is 4426165368 loops to solve the basic 8 queens problem... This is gonna take forever. Let's try a different approach.
 
 Fixing queens to seperated rows didn't help much either. It still takes 8^8 loops, which is 16777216 loops.
 
 
 ![nCr formula](ncr.png)
 
 
 **👇Just go to next page**
 */
//: [Another approach](@next)
