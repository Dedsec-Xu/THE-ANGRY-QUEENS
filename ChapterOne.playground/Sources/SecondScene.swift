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
    
    public var waitt = 100
    var boxsize = 0.0
    var boxes = [SKSpriteNode]()
    var queens = [SKSpriteNode]()
    var nodes = [SKSpriteNode]()
    var queenxs = [Int]()
    var queenys = [Int]()
    var FightingFlag = 0
    var FightIndex1 = 0
    var FightIndex2 = 0
    var queenpos = [Int]()
    
    
    
    
    enum GameStatus {
        case idle//initialize
        case running//running
        case over//over
    }
    var gameStatus: GameStatus = .idle//current state

    

    
    public override func didMove(to view: SKView) {
        
        let Node_Title = SKSpriteNode(imageNamed: "title2.png")
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
                gameStatus = .running
            
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

            }
        }
        for i1 in 0..<iterk{

            queenpos.append(0)
            let posx = CGFloat((Double(i1)*boxsize)+40.0+boxsize/2)
            let posy = CGFloat((Double(queenpos[i1])*boxsize)+120.0+boxsize/2)

            let point = CGPoint(x: posx, y: posy)

            print("putChess")
            putChess(at: point, csize: CGFloat(boxsize), imagename: "queen.png", chessname: "queen")
        }
        gameStatus = .running
        for i1 in 0..<iterk{
            
            queenpos.append(0)
            let posx = CGFloat((Double(i1)*boxsize)+40.0+boxsize/2)
            let posy = CGFloat((Double(queenpos[i1])*boxsize)+120.0+boxsize/2)
            
            let point = CGPoint(x: posx, y: posy)
            
            print("putChess")
            putChess(at: point, csize: CGFloat(boxsize), imagename: "queen.png", chessname: "queen")
        }
        
        for i1 in 0..<iterk{
            for i2 in 0..<iterk{
                for i3 in 0..<iterk{
                    for i4 in 0..<iterk{
                        for i5 in 0..<iterk{
                            for i6 in 0..<iterk{
                                for i7 in 0..<iterk{
                                    for i8 in 1..<iterk{
                                        queenpos[0] = i8
                                        queenpos[1] = i7
                                        queenpos[2] = i6
                                        queenpos[3] = i5
                                        queenpos[4] = i4
                                        queenpos[5] = i3
                                        queenpos[6] = i2
                                        queenpos[7] = i1
                                        move()
                                        print("moved")
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    func gameOver()  {
        
        //over
        
        gameStatus = .over
        
    }
    
    func move()  {
        
        //over
        for i in 1..<iterk{
            let posx = CGFloat((Double(i)*boxsize)+40.0+boxsize/2)
            let posy = CGFloat((Double(queenpos[i])*boxsize)+120.0+boxsize/2)
            let point = CGPoint(x: posx, y: posy)
            let move = SKAction.move(to: point, duration: (Double(waitt)/1000))
            queens[i].run(move)
        }
        
        gameStatus = .over
        
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
