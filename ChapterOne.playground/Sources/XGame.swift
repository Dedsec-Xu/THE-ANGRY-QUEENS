import PlaygroundSupport
import SpriteKit
import Foundation
import GameKit
import AVFoundation


public class XGame: SKScene {
    private var label : SKLabelNode!
    var lineWiseX : CGFloat = 0
    var lineWiseY : CGFloat = 0
    var jumpedAhead = false
    public var iterk = 8
    public var MaxRound = 50
    
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
    var attacker = 0
    var round = 0
    var lastround = 0
    var Node_Congrats = SKSpriteNode(imageNamed: "CONGRATS.png")
    
    

    
    
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
        
        
        shuffle()
    }
    
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch gameStatus {
            case .idle:
                startGame()
                gameStatus = .running
            case .running:
                for touch in touches {
                    
                    print("tapped")
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
                            putChess(at: point, csize: CGFloat(boxsize), imagename: "queen.png", chessname: "queen", temp: true)
                            lose(n: iterx)
                            
                            gameStatus = .over
                        }else{
                            let posx = CGFloat((Double(iterx)*boxsize)+40.0+boxsize/2)
                            let posy = CGFloat((Double(itery)*boxsize)+120.0+boxsize/2)
                            let point = CGPoint(x: posx, y: posy)
                            moveChess(at: point, n: iterx)
                            tapqueen[iterx]=itery
                            showChess(n: iterx)
                            var win = checkchess(n: iterx)
                            print(win)
                            if win==false{
                                
                                print("lose(n:\(attacker))")
                                lose(n:attacker)
                                
                                gameStatus = .over
                            }else{
                                for i in 0..<iterk{
                                    if tapqueen[i] == -1{
                                        win = false
                                        break
                                    }
                                }
                                if win{
                                    
                                    print("won")
                                    gameStatus = .over
                                    won()
                                }
                            }
                        }
                    }
                }
            
            
            case .over:
                gameStatus = .over
        }
    }

    
    
    
    func putqueen(at row: Int) {
        if row==iterk{
            total = total+1
            queenlib.append(queenpos2)
            print("total is \(total)")
            
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
        
        

        
    

    func shuffle()  {
        
        gameStatus = .idle
        
    }
    
    func startGame()  {
        
        
        
        lastround = Int(floor(Double(MaxRound)/Double(iterk)))
        if lastround<1{
            lastround = 1
        }
        for _ in 0..<iterk{
            queenpos2.append(0)
        }
        let Node_Background = SKSpriteNode(imageNamed: "back.png")
        Node_Background.name = "background"
        Node_Background.setScale(1)//to show background
        Node_Background.position = CGPoint(x: frame.midX, y: frame.midY)
        nodes.append(Node_Background)
        addChild(nodes[nodes.endIndex-1])
        Foundtext.text = "Round 1 of \(MaxRound) rounds"
        Foundtext.fontSize = 30.0
        Foundtext.fontColor = SKColor.yellow
        Foundtext.position = CGPoint(x: self.frame.midX, y: 60)
        addChild(Foundtext)
        
        Node_Congrats.name = "CONGRATS"
        Node_Congrats.setScale(0.01)//to show background
        Node_Congrats.position = CGPoint(x: frame.midX, y: frame.midY)
        Node_Congrats.alpha = 0
        addChild(Node_Congrats)
        
        BGM.play()
        
        putqueen(at:0)
        let rand = Int.random(in: 0..<total)
        for i in 0..<iterk{
            queenpos.append(queenlib[rand][i])
            tapqueen.append(-1)
        }
        
        print(queenpos)

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
        
        for i1 in 0..<iterk{
            
            let posx = CGFloat((Double(i1)*boxsize)+40.0+boxsize/2)
            let posy = CGFloat((Double(queenpos[i1])*boxsize)+120.0+boxsize/2)

            let point = CGPoint(x: posx, y: posy)
            putChess(at: point, csize: CGFloat(boxsize), imagename: "queen.png", chessname: "queen", temp: false)
            showChess(n:i1)
        }
        
        randomqueen(ThrowAway: 1)
        
        gameStatus = .running
    }
    
    func randomqueen(ThrowAway t: Int){
        let rand = Int.random(in: 0..<total)
        for i in 0..<iterk{
            queenpos[i] = queenlib[rand][i]
            tapqueen[i] = queenpos[i]
        }
        if t>iterk{
            for i in 0..<iterk{
                tapqueen[i] = -1
            }
            
        }else{
            
            let rand = Int.random(in: 0..<(iterk-t+1))
            print("rand=\(rand)")
            for i in rand...(rand+t-1){
                hideChess(n: i)
                tapqueen[i] = -1
            }
            for i in 0..<rand{
                showChess(n: i)
                tapqueen[i] = queenpos[i]
                let posx = CGFloat((Double(i)*boxsize)+40.0+boxsize/2)
                let posy = CGFloat((Double(queenpos[i])*boxsize)+120.0+boxsize/2)
                
                let point = CGPoint(x: posx, y: posy)
                moveChess(at: point, n: i)
            }
            if (rand+t)<iterk{
                
                for i in (rand+t)..<iterk{
                    
                    showChess(n: i)
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
    
    
    func checkchess(n iter: Int)->Bool  {
        for i in 0..<iterk{
            if tapqueen[i] == -1{
                continue
            }
            if i==iter{
                continue
            }
            print("checking \(i):\(tapqueen[i]) and\(iter):\(tapqueen[iter])")
            if tapqueen[iter]==tapqueen[i]{
                attacker = i
                return false
            }else if (abs(tapqueen[iter]-tapqueen[i])==abs(iter-i)){
                
                attacker = i
                return false
            }
        }
        return true
    }
    
    func lose(n FightIndex: Int)  {
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
        
        queens[FightIndex].run(jump)
        Node_Background.run(showfight)
        gameStatus = .over
        
    }
    
    func won()  {
        
        gameStatus = .over
        Node_Congrats.alpha = 1

        let wait = SKAction.wait(forDuration: 0.3)
        let resize = SKAction.scale(by: 100, duration: 0.3)
        let showfight = SKAction.sequence([wait,resize])
        
        let action = SKAction.playSoundFileNamed("Yay.mp3", waitForCompletion: false)
        self.run(action)
        
        Node_Congrats.run(showfight,completion:{
            self.nextround()
        })
        
        
    }

    func nextround()  {
        
        round=round+1
        Foundtext.text = "Round \(round) of \(MaxRound) rounds"
        print("nextround:\(round)")
        print("lastround:\(lastround)")
        
        var drop = round/lastround+1
        if drop>iterk{
            drop=iterk
        }
        print("\(drop)")
        randomqueen(ThrowAway: drop)
        Node_Congrats.setScale(0.01)
        Node_Congrats.alpha = 0
        gameStatus = .running
        
        
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
    
    func putChess(at point: CGPoint, csize r: CGFloat, imagename name: String, chessname name2: String, temp t: Bool) {
        
        let shape = SKSpriteNode()
        
        shape.texture = SKTexture(imageNamed: name)
        shape.name = "queenChess"
        shape.size = CGSize(width:r, height: r)
        shape.position = CGPoint(x: point.x, y: point.y)
        queens.append(shape)
        addChild(queens[queens.endIndex-1])
    }
    
    func moveChess(at point: CGPoint, n num:Int) {
        
        print("moveChess \(num)")
        
        queens[num].position = point
    }
    
    func hideChess(n num:Int) {
        
        print("hideChess \(num)")
        queens[num].alpha = 0
    }
    
    func showChess(n num:Int) {
        
        print("showChess \(num)")
        
        queens[num].alpha = 1
    }
    
    
    

        
         
        
        
        //addLinewiseShape()
        
        
        
        // let Str_ButtonName = "button";
}

