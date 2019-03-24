//: [Previous page](@previous)
/*:
 # How can we speed up the process?
 As we can see, In brute force process. When the 👸queens in the first two rows are already fighting, the program is still trying to move the queens in other rows, which is completely waste of time.
 
 
 ![BFEXAPMLE](BFEXAPMLE.jpg)
 
 
 Here is a search tree.
 
 
 ![tree](tree.png)
 
 
Each node indicates the position of the queen on her row. The brute force algorithm goes through the whole tree. But if we can cut the brach when the first few queens are already fighting, we should be able to see a huge improvement on speed.
 
 
 ![cutted](cutted.png)
 
 
 The way we do it is using backtracking↩️ algorithm. When one try failed, the program tracks back to the father node of the search tree and place the queen at another spot. This loops until all solves are found.
 
 
 **👇You can change the amount of queens here(4~10).**
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

let scene = ThirdScene(size: CGSize(width: 480, height: 640))
var 👸 = 4
var 😡 = true
var 🕐 = 1000

//#-end-hidden-code
👸 = /*#-editable-code number of queens♕*/8/*#-end-editable-code*/

/*:
 
 **👇You can change the speed of animations by changing the wait time(1~1000).**
 
 */

🕐 = /*#-editable-code move speed*/1/*#-end-editable-code*/



/*:
The simplest way to implement the algorithm is using Recursion
 
TryPlaceQueen(at row: Int){
 if row==👸{
    total++;
 }
 else{
    for col in 0..<👸{
        c[row]=col
        if is_ok(at:row){
            queen(row+1)
        }
    }
 }
 
 */

//#-hidden-code

if 🕐<1{
    scene.waitt = 1
}else if 🕐 > 1000{
    scene.waitt = 1000
}else{
    scene.waitt = 🕐
}


if 👸<4{
    scene.iterk = 3
}else if 👸 > 10{
    scene.iterk = 20
}else{
    scene.iterk = 👸
}

scene.scaleMode = .aspectFill

sceneView.presentScene(scene)

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView


//#-end-hidden-code
/*:
 # This is going to take forever!
 
 It seems that brute force is too slow🐢 when 👸 is too big!
 
 
 Let's do a small calculation:
 n queens problem have n^2Cn possible solves. So it takes 64C8 loops, which is 4426165368 loops to solve the  8 queens problem... This is gonna take forever. Let's try a different approach.
 
 Fixing queens to seperated rows didn't help much either. It still takes 8^8 loops, which is 16777216 loops.
 
 
 ![nCr formula](ncr.png)
 
 
 **👇Just go to next page**
 */
//: [Another approach](@next)
