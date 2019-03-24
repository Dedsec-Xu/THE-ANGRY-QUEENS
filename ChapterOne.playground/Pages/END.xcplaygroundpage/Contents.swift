//: [Previous page](@previous)
/*:
 # Let's play a game😎
 
  ![title](4title.png)
 
 Put down the missing 👸queens as soon as possible. The difiicluty is increasing over time. You can change the variables of the game as you want.
 
 
 **Explore the game🎮 at your own pace.**
 
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

let scene = XGame(size: CGSize(width: 480, height: 640))
var 👸 = 4
var 🎮 = 4

//#-end-hidden-code
👸 = /*#-editable-code number of queens♕*/4/*#-end-editable-code*/
/*:
 **👇You can change the max round of the game here(10~100).**
*/

🎮 = /*#-editable-code number of queens♕*/50/*#-end-editable-code*/
//#-hidden-code


if 👸<4{
    scene.iterk = 3
}else if 👸 > 10{
    scene.iterk = 20
}else{
    scene.iterk = 👸
}

if 🎮<10{
    scene.MaxRound = 10
}else if 🎮 > 100{
    scene.MaxRound = 1000
}else{
    scene.MaxRound = 🎮
}

scene.scaleMode = .aspectFill

sceneView.presentScene(scene)

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView


//#-end-hidden-code
/*:
 # 🎊THE END!🎊
 
 This is the end of my playground. I put a lot of effort into it. I hope you enjoyed it.
 
 #THANK YOU🙏 VERY MUCH FOR PLAYING!😄
 */
//: [Another approach](@next)
