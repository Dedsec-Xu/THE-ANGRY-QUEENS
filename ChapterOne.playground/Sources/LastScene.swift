import PlaygroundSupport
import SpriteKit
import Foundation
import GameKit
import AVFoundation


public class LastScene: SKScene {
    private var label : SKLabelNode!
    var lineWiseX : CGFloat = 0
    var lineWiseY : CGFloat = 0
    var jumpedAhead = false
    public var iterk = 8
    public var blank = 8
    public var waitt = 100
    var boxsize = 0.0
    var boxes = [SKSpriteNode]()
    var queens = [SKSpriteNode]()
    var nodes = [SKSpriteNode]()
    var queenpos = [Int]()
    
    var tapqueen = [Int]()
    var queenposstart = [Int]()
    var queenpos2 = [Int]()
    var queenlib = [[Int]]()
    var solves = 0
    var placed = 0
    
    var Foundtext = SKLabelNode(fontNamed: "Helvetica")
    var SolveDisp = [SKLabelNode]()
    var Finished = 0
    var total = 0
    
    var disprow = 0
    var lastdisprow = 0
    var currentrow = 0
    var endloop = 0
    
    var draw = 0
    
    var BGM = AVAudioPlayer()
    

    
    
    enum GameStatus {
        case idle//initialize
        case running//running
        case over//over
    }
    var gameStatus: GameStatus = .idle//current state

    

    
    public override func didMove(to view: SKView) {
        let BGMpath = Bundle.main.path(forResource: "It_Devours", ofType: "mp3")!
        let BGMurl = URL(fileURLWithPath: BGMpath)
        do{
            
             BGM = try AVAudioPlayer(contentsOf: BGMurl)
        }catch{
            print("❗️no music file")
        }
        BGM.numberOfLoops = -1
        let Node_Title = SKSpriteNode(imageNamed: "fun.png")
        Node_Title.name = "background"
        Node_Title.setScale(1)//to show background
        Node_Title.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(Node_Title)
        boxsize = 400.0/Double(iterk)
        
//        print(boxsize)
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
                gameStatus = .running
            case .running:
                //                print("putqueen")
                for touch in touches {
                    let position = touch.location(in: self)
                    print(position)
                    let node = self.atPoint(position)
                    if node.name == "textureFig" {
                        let figure = node as? SKSpriteNode
                        let index = boxes.index(of: figure!)
                        let iterx = (index!)/iterk
                        let itery = (index!)%iterk
                        if tapqueen[iterx] != -1 {
                            
                            let posx = CGFloat((Double(iterx)*boxsize)+40.0+boxsize/2)
                            let posy = CGFloat((Double(itery)*boxsize)+120.0+boxsize/2)
                            let point = CGPoint(x: posx, y: posy)
                            putChess(at: point, csize: CGFloat(boxsize), imagename: "queen.png", chessname: "queen")
                            lose()
                        }else{
                            let posx = CGFloat((Double(iterx)*boxsize)+40.0+boxsize/2)
                            let posy = CGFloat((Double(itery)*boxsize)+120.0+boxsize/2)
                            let point = CGPoint(x: posx, y: posy)
                            moveChess(at: point, n: iterx)
                            
                            print("pos")
                            print(iterx)
                            print(itery)
                            print(queens.endIndex)
                            if queens.endIndex>0 {
                                print("check")
                            }
                            
                        }
                        
                        
                        
                        print("append")
                        
                        
                        print("putChess")
                        var calcchessname = "queen"
                        calcchessname += " "
                        calcchessname += String(iterx)
                        calcchessname += " "
                        calcchessname += String(itery)
//                        putChess(at: point, csize: CGFloat(boxsize), imagename: "queen.png", chessname: calcchessname)
//                        if FightingFlag==1{
//                            Fight()
//                        }else if queens.endIndex==iterk{
//                            Congrats()
//                        }
                    }
                }
            
            case .over:
                gameStatus = .over
        }
    }
    
//    func calculatenext(){
//
//    }
    
    
    
    func putqueen(at row: Int) {
        if row==iterk{
            total = total+1
            queenlib.append(queenpos2)
            print("total is \(total)")
            Foundtext.text = "Found \(total) Solves"
            
        }else{
            for col in 0..<iterk {
                queenpos2[row]=col
                if is_ok(at: row){
                
                    putqueen(at: (row+1))
                    
                }
            }
        }
    }
    
    
    func is_ok(at row: Int) -> Bool{
        for j in 0..<row{
            if ((queenpos2[row]==queenpos2[j])||(abs(row-j)==abs(queenpos2[row]-queenpos2[j]))){
            return false
            }
        }
            
        return true
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
        
        
    func moveChess(at point: CGPoint, n num:Int) {
        
        let shape = SKSpriteNode()
        
        shape.texture = SKTexture(imageNamed: "queen.png")
        shape.name = "queenChess"
        shape.size = CGSize(width:CGFloat(boxsize), height: CGFloat(boxsize))
        shape.position = CGPoint(x: point.x, y: point.y)
        queens.append(shape)
        addChild(queens[queens.endIndex-1])
    }
    
    func hideChess(n num:Int) {
        
        queens[num].alpha = 0
    }
    
    func showChess(n num:Int) {
        
        queens[num].alpha = 0
    }

    func shuffle()  {
        
        //initialize
        
        gameStatus = .idle
        
    }
    
    func startGame()  {
        for _ in 0..<iterk{
            queenpos2.append(0)
        }
        let Node_Background = SKSpriteNode(imageNamed: "back.png")
        Node_Background.name = "background"
        Node_Background.setScale(1)//to show background
        Node_Background.position = CGPoint(x: frame.midX, y: frame.midY)
        nodes.append(Node_Background)
        addChild(nodes[nodes.endIndex-1])
//        let action = SKAction.playSoundFileNamed("It_Devours.mp3", waitForCompletion: false)
//        self.run(action)
        
        BGM.play()
        
        putqueen(at:0)
        let rand = Int.random(in: 0..<total)
        for i in 0..<iterk{
            queenpos.append(queenlib[rand][i])
            tapqueen.append(-1)
        }
        
        print(queens)

//        Foundtext.text = "Found 0 Solves"
//        Foundtext.fontSize = 30.0
//        Foundtext.fontColor = SKColor.yellow
//        Foundtext.position = CGPoint(x: self.frame.midX, y: 55)
//        self.addChild(Foundtext)
    
        
//        let startScreen = SKLabelNode(fontNamed: "Helvetica")
//        startScreen.text = "⬅️ Recent Solve"
//        startScreen.fontSize = 29.0
//        startScreen.fontColor = SKColor.yellow
//        startScreen.position = CGPoint(x: self.frame.midX*1.3, y: 580)
//        self.addChild(startScreen)

        for iterx in 0..<iterk  {
            for itery in 0..<iterk  {
                var name = "pat2.png"
                if ((iterx+itery)%2==0){
                    name = "pat1.png"
                }

                let posx = CGFloat((Double(iterx)*boxsize)+40.0+boxsize/2)
                let posy = CGFloat((Double(itery)*boxsize)+120.0+boxsize/2)
//                print(posy)
                let point = CGPoint(x: posx, y: posy)
                createPat(at: point, csize: CGFloat(boxsize), imagename: name)

            }
        }
        randomqueen(ThrowAway: 1)
        for i1 in 0..<iterk{

//            queenpos.append(0)
//            queenposstart.append(0)
            let posx = CGFloat((Double(i1)*boxsize)+40.0+boxsize/2)
            let posy = CGFloat((Double(queenpos[i1])*boxsize)+120.0+boxsize/2)

            let point = CGPoint(x: posx, y: posy)
            putChess(at: point, csize: CGFloat(boxsize), imagename: "queen.png", chessname: "queen")
            
        }
        
        gameStatus = .running
    }
    
    func randomqueen(ThrowAway t: Int){
        if t>iterk{
            for i in 0..<iterk{
                tapqueen[i] = -1
            }
            
        }else{
            
            let rand = Int.random(in: 0..<(iterk-t+1))
            for i in rand...(rand+t-1){
                tapqueen[i] = -1
            }
            for i in 0..<rand{
                tapqueen[i] = queenpos[i]
                let posx = CGFloat((Double(i)*boxsize)+40.0+boxsize/2)
                let posy = CGFloat((Double(queenpos[i])*boxsize)+120.0+boxsize/2)
                
                let point = CGPoint(x: posx, y: posy)
                moveChess(at: point, n: i)
            }
            if (rand+t)<iterk{
                for i in (rand+t)..<iterk{
                    tapqueen[i] = queenpos[i]
                    let posx = CGFloat((Double(i)*boxsize)+40.0+boxsize/2)
                    let posy = CGFloat((Double(queenpos[i])*boxsize)+120.0+boxsize/2)
                    
                    let point = CGPoint(x: posx, y: posy)
                    moveChess(at: point, n: i)
                }
            }
            
        }
        
        
    }
    
    
    func gameOver()  {
        
        //over
        
        gameStatus = .over
        
    }
    
    func movequeens()  {
        
        
    }
    func lose()  {
        
        
    }
    func nextround()  {
        
        
    }
        
    
    
    
    

        
         
        
        
        //addLinewiseShape()
        
        
        
        // let Str_ButtonName = "button";
}

