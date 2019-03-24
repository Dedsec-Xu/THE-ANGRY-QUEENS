//: [Previous page](@previous)
/*:
 # How can we speed up the process?
 
  ![title](3title.png)
 
 As we can see, In brute force process. When the 👸queens in the first two rows are already fighting, the program is still trying to move the queens in other rows, which is a completely waste of time🕐.
 
 
 ![waste](waste.png)
 
 In order to solve this problem, we should first learn about how searches work. Here is a search tree🌲. Each node indicates the position of the 👸queen on her row. So the 🌲tree can represent all possible solves, which is called the search space.
 
 
 ![tree](tree.png)
 
 
 Search process is to find all solves in the tree. The brute force💪 algorithm goes through the whole 🌲tree. So if we can cut the brach whenever the already placed queens are fighting and stop search deeper, we should be able to see a huge improvement on speed. This is called Pruning.
 
 
 ![cutted](cutted.png)
 
 
 The way we implement it is using backtracking↩️ algorithm. When one try failed, the program tracks back to the father node of the search 🌲tree and place the queen at another spot. This loops until all solves are found.
 
 The simplest way to implement the backtracking↩️ algorithm is using Recursion:
 ```swift
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
 ```
 
 
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
 # Result: This is way faster!
 
 After implementing the backtracking↩️ algorithm. The improvement on speed is significant. You can try different 👸 values to see clearly how the algorithm works. Compare the results with the chart below.
 
 
 ![solves](solves.jpg)

 
 The backtracking↩️ algorithm is a classic algorithm that is used in multiple problems, such as The ♘Knight’s tour problem, m 🌈Coloring Problem and Sudoku Problem. This playground should give you a more straight forward impression on the algorithm.
 
 
 ![Sudoku](Sudoku.gif)
 
 
 Time for a little game👾 after study. 
 
 **👇Little game👾**
 */
//: [Another approach](@next)
