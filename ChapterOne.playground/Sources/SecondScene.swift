import PlaygroundSupport
import SpriteKit
import Foundation
import GameKit

public class SecondScene: SKScene {
    private var label : SKLabelNode!
    let buttonNodeName = "button"
    var lineWiseX : CGFloat = 0
    var lineWiseY : CGFloat = 0
    var jumpedAhead = false
    public var iterk = 8
    var boxsize = 0.0
    var boxes = [SKSpriteNode]()
    var queens = [SKSpriteNode]()
    var nodes = [SKSpriteNode]()
    var queenxs = [Int]()
    var queenys = [Int]()
    var FightingFlag = 0
    var FightIndex1 = 0
    var FightIndex2 = 0
    
    
    
    
    enum GameStatus {
        case idle//initialize
        case running//running
        case over//over
    }
    var gameStatus: GameStatus = .idle//current state

    

    
    public override func didMove(to view: SKView) {
        
        let Node_Title = SKSpriteNode(imageNamed: "title.png")
        Node_Title.name = "background"
        Node_Title.setScale(1)//to show background
        Node_Title.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(Node_Title)
        boxsize = 400.0/Double(iterk)
        print(boxsize)
//        let posx = CGFloat(Double(1)*boxsize/300.0+120.0)
//        let posy = CGFloat(Double(1)*boxsize/300.0+40.0)
//        let point = CGPoint(x: posx, y: posy)
//        createPat(at: point, csize: CGFloat(boxsize), imagename: "pat2.png")
        
        
        shuffle()
    }
    
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch gameStatus {
            case .idle:
                startGame()
            case .running:
                for touch in touches {
                    let position = touch.location(in: self)
                    print(position)
                    let node = self.atPoint(position)
                    if node.name == "textureFig" {
                        let figure = node as? SKSpriteNode
                        let index = boxes.index(of: figure!)
                        let iterx = (index!)/iterk
                        let itery = (index!)%iterk
                        let posx = CGFloat((Double(iterx)*boxsize)+40.0+boxsize/2)
                        let posy = CGFloat((Double(itery)*boxsize)+120.0+boxsize/2)
                        print("pos")
                        print(iterx)
                        print(itery)
                        print(queens.endIndex)
                        if queens.endIndex>0 {
                            checkFight(ix: iterx, iy: itery)
                            print("check")
                        }
                        
                        
                        
                        queenxs.append(iterx)
                        queenys.append(itery)
                        print("append")
                        let point = CGPoint(x: posx, y: posy)
                        
//                        print(index)
//                        self.logic?.userChoose(index: index!)
                        print(queenxs)
                        print(queenys)
                        
                        print("putChess")
                        var calcchessname = "queen"
                        calcchessname += " "
                        calcchessname += String(iterx)
                        calcchessname += " "
                        calcchessname += String(itery)
                        putChess(at: point, csize: CGFloat(boxsize), imagename: "queen.png", chessname: calcchessname)
                        if FightingFlag==1{
                            Fight()
                        }else if queens.endIndex==iterk{
                            Congrats()
                        }
                    }
                }
            
            case .over:
                gameStatus = .over
        }
    }
        
        
    func createPat(at point: CGPoint, csize r: CGFloat, imagename name: String) {
        
        let shape = SKSpriteNode()
        
        shape.texture = SKTexture(imageNamed: name)
        shape.name = "textureFig"
        shape.size = CGSize(width:r, height: r)
        shape.position = CGPoint(x: point.x, y: point.y)
        boxes.append(shape)
        addChild(boxes[boxes.endIndex-1])
    }
    
    func putChess(at point: CGPoint, csize r: CGFloat, imagename name: String, chessname name2: String) {
        
        let shape = SKSpriteNode()
        
        shape.texture = SKTexture(imageNamed: name)
        shape.name = "queenChess"
        shape.size = CGSize(width:r, height: r)
        shape.position = CGPoint(x: point.x, y: point.y)
        queens.append(shape)
        addChild(queens[queens.endIndex-1])
    }
    
    func shuffle()  {
        
        //initialize
        
        gameStatus = .idle
        
    }
    
    func startGame()  {
        let Node_Background = SKSpriteNode(imageNamed: "back.png")
        Node_Background.name = "background"
        Node_Background.setScale(1)//to show background
        Node_Background.position = CGPoint(x: frame.midX, y: frame.midY)
        nodes.append(Node_Background)
        addChild(nodes[nodes.endIndex-1])
        let action = SKAction.playSoundFileNamed("ding.wav", waitForCompletion: false)
        self.run(action)

        
        //start
        for iterx in 0..<iterk  {
            for itery in 0..<iterk  {
                var name = "pat2.png"
                if ((iterx+itery)%2==0){
                    name = "pat1.png"
                }
                
                let posx = CGFloat((Double(iterx)*boxsize)+40.0+boxsize/2)
                let posy = CGFloat((Double(itery)*boxsize)+120.0+boxsize/2)
                print("pos")
                print(posy)
                let point = CGPoint(x: posx, y: posy)
                createPat(at: point, csize: CGFloat(boxsize), imagename: name)
                //                createPat(at: point, csize: CGFloat(boxsize), imagename: "queen.png")
            }
        }
        gameStatus = .running
        
    }
    
    func gameOver()  {
        
        //over
        
        gameStatus = .over
        
    }
    
    func Fight(){
        gameOver()
        
        
        let action = SKAction.playSoundFileNamed("fight.mp3", waitForCompletion: false)
        self.run(action)
        let moveActionup = SKAction.moveBy(x: 0, y: 20, duration: 0.3)
        let moveActiondown = SKAction.moveBy(x: 0, y: -20, duration: 0.3)
//        let rotateAction = SKAction.rotate(byAngle: π, duration: 0.5)
        let jump = SKAction.sequence([moveActionup, moveActiondown])
        let Node_Background = SKSpriteNode(imageNamed: "fighting.png")
        Node_Background.name = "background"
        Node_Background.setScale(0.01)//to show background
        Node_Background.position = CGPoint(x: frame.midX, y: frame.midY)
        nodes.append(Node_Background)
        addChild(nodes[nodes.endIndex-1])
        
        let wait = SKAction.wait(forDuration: 0.3)
        let resize = SKAction.scale(by: 100, duration: 0.3)
        let showfight = SKAction.sequence([wait, resize])
        
        queens[FightIndex1].run(jump)
        Node_Background.run(showfight)
    }
    
    func Congrats(){
        gameOver()
        
        
        let action = SKAction.playSoundFileNamed("Yay.mp3", waitForCompletion: false)
        self.run(action)
       
        let Node_Background = SKSpriteNode(imageNamed: "CONGRATS.png")
        Node_Background.name = "CONGRATS"
        Node_Background.setScale(0.01)//to show background
        Node_Background.position = CGPoint(x: frame.midX, y: frame.midY)
        nodes.append(Node_Background)
        addChild(nodes[nodes.endIndex-1])
        
        let wait = SKAction.wait(forDuration: 0.3)
        let resize = SKAction.scale(by: 100, duration: 0.3)
        let showfight = SKAction.sequence([wait, resize])
        

        Node_Background.run(showfight)
    }
    
    func checkFight(ix cx: Int, iy cy: Int){
        
        
        for i in 0...(queens.endIndex-1){
            print("cheking")
            
            
            let tx = queenxs[i]
            let ty = queenys[i]
            let dx = abs(tx-cx)
            let dy = abs(ty-cy)
            
            if tx==cx{
                FightingFlag = 1
                FightIndex1 = i
                FightIndex2 = queens.endIndex
                break
            }else if cy == ty{
                FightingFlag = 1
                FightIndex1 = i
                FightIndex2 = queens.endIndex
                break
            }else if dy == dx{
                FightingFlag = 1
                FightIndex1 = i
                FightIndex2 = queens.endIndex
                break
            }
        }
        print(FightingFlag)
    }
    
    


        
        
        
        
        //addLinewiseShape()
        
        
        
        // let Str_ButtonName = "button";
    
    
    
    
}
