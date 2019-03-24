import PlaygroundSupport
import SpriteKit
import Foundation
import GameKit

public class ThirdScene: SKScene {
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
    var queenpos = [Int]()
    var queenposstart = [Int]()
    var queenpos2 = [Int]()
    var solves = 0
    
    var Foundtext = SKLabelNode(fontNamed: "Helvetica")
    var SolveDisp = [SKLabelNode]()
    var Finished = 0
    var total = 0
    
    var disprow = 0
    var lastdisprow = 0
    var currentrow = 0
    var endloop = 0
    
    var draw = 0

    
    
    
    
    enum GameStatus {
        case idle//initialize
        case running//running
        case over//over
    }
    var gameStatus: GameStatus = .idle//current state

    

    
    public override func didMove(to view: SKView) {
        
        let Node_Title = SKSpriteNode(imageNamed: "backtracking.png")
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
                putqueen()
                gameStatus = .over
            
            case .over:
                gameStatus = .over
        }
    }
    
//    func calculatenext(){
//
//    }
    
    
    func putqueen() {
            
//            if currentrow==iterk{
//
//            }
            
        print("total is \(total)")
        print("queenpos2[\(currentrow)] = queenposstart[\(currentrow)]=\(queenposstart[currentrow])")
        queenpos2[currentrow] = queenposstart[currentrow]
        
        queenposstart[currentrow] = queenpos2[currentrow]+1
        if (currentrow==0)&&(queenpos2[currentrow]>=iterk){
            endloop = 1
        }else if queenpos2[currentrow]==iterk{
            queenpos2[currentrow] = 0
            queenposstart[currentrow] = 0
            currentrow = currentrow-1
            
        }else if queenpos2[currentrow]<iterk&&is_ok(at: currentrow)&&currentrow<(iterk-1){
//            print("is_ok(at: \(currentrow)")
            currentrow = currentrow+1
            draw = 1
        }
        else if currentrow==iterk-1&&is_ok(at: currentrow){
            total = total+1
            print(queenpos2)
            for i in 0..<iterk{
                var TempString = ""
                for j in 0..<iterk{
                    if queenpos2[j]==(iterk-i-1){
                        TempString += "👸"
                    }else {
                        TempString += "◻️"
                    }
                }
                SolveDisp[i].text = TempString
                
            }
            let action = SKAction.playSoundFileNamed("ding.wav", waitForCompletion: false)
            self.run(action)
            solves = solves+1
            
            Foundtext.text = "Found \(total) Solves"
        }
        
        for it in (currentrow+1)..<iterk{
            queens[it].alpha = 0.25
        }
        for it in 0...currentrow{
            queens[it].alpha = 1
        }
        
        if draw==0{
            if endloop==0{
                putqueen()
            }
            
                
        }
        else{
            draw = 0
            print("\(currentrow)")
            let posx = CGFloat((Double(currentrow-1)*boxsize)+40.0+boxsize/2)
            let posy = CGFloat((Double(queenpos2[currentrow-1]%iterk)*boxsize)+120.0+boxsize/2)
            let point = CGPoint(x: posx, y: posy)
            
            let move1 = SKAction.move(to: point, duration: (Double(waitt)/100000))
            if endloop==0{
                queens[currentrow-1].run(move1, completion: {
                    self.putqueen()
                })
            }
            
        }
        
        if endloop==1{
            
            for it in 0..<iterk{
                queens[it].alpha = 1
                let posx = CGFloat((Double(it)*boxsize)+40.0+boxsize/2)
                let posy = CGFloat((Double(queenpos2[it]%iterk)*boxsize)+120.0+boxsize/2)
                let point = CGPoint(x: posx, y: posy)
                
                let move1 = SKAction.move(to: point, duration: (Double(waitt)/100000))
                queens[it].run(move1)
            }
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
        
        
            
//                            let waitAction = SKAction.wait(forDuration: (Double(waitt)/100000))
//                            self.run(waitAction)
        
            
        
    }
    
    
    
//    func putqueen(at row: Int) {
//        if row==iterk{
//            total = total+1
//            print("total is \(total)")
//
//            Foundtext.text = "Found \(total) Solves"
//        }else{
//            for col in 0..<iterk {
//                queenpos2[row]=col
//                print("queenpos2[\(row)]=\(queenpos2[row])")
//
//                if is_ok(at: row){
//                    disprow = row
//                    print("lastdisprow=\(lastdisprow)")
//
//                    print("disprow=\(disprow)")
//                    if disprow<iterk-1{
//                        for i in (disprow+1)...(iterk-1){
//                            queens[i].alpha = 0.25
//
//                        }
//                    }
//                    for i in 0...disprow{
//                        queens[i].alpha = 1
//
//                    }
//
//                    lastdisprow = disprow
//                    for i in 0...disprow{
//                        let posx = CGFloat((Double(i)*boxsize)+40.0+boxsize/2)
//                        let posy = CGFloat((Double(queenpos2[i]%iterk)*boxsize)+120.0+boxsize/2)
//                        let point = CGPoint(x: posx, y: posy)
//
//                        if i==disprow{
//                            let move1 = SKAction.move(to: point, duration: 0)
//                            queens[i].run(move1)
//                            sleep(1)
////                            let waitAction = SKAction.wait(forDuration: (Double(waitt)/100000))
////                            self.run(waitAction)
//                        }else{
//                            let move1 = SKAction.move(to: point, duration: 0)
//                            queens[i].run(move1)
//                        }
//                    }
//                    putqueen(at: (row+1))
//
//
//
//                }
//
//            }
//        }
//    }
    
    
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
        let action = SKAction.playSoundFileNamed("It_Devours.mp3", waitForCompletion: false)
        self.run(action)
        

        Foundtext.text = "Found 0 Solves"
        Foundtext.fontSize = 30.0
        Foundtext.fontColor = SKColor.yellow
        Foundtext.position = CGPoint(x: self.frame.midX, y: 55)
        self.addChild(Foundtext)
        
        for i in 0..<iterk{
            let TempLabelNode = SKLabelNode(fontNamed: "Helvetica")
            var Temptext = ""
            for _ in 0..<iterk{
                Temptext += "◻️"
            }
            TempLabelNode .text = Temptext
//            startScreen.text = "◻️◻️💃◻️◻️◻️◻️◻️"
            TempLabelNode .fontSize = 80/CGFloat(iterk)
            TempLabelNode .fontColor = SKColor.yellow
            TempLabelNode .position = CGPoint(x: self.frame.midX/2, y: CGFloat(640-(120.0/Double(iterk+1))*Double(i+1)))
            SolveDisp.append(TempLabelNode )
            self.addChild(SolveDisp[SolveDisp.endIndex-1])
        }
        
        let startScreen = SKLabelNode(fontNamed: "Helvetica")
        startScreen.text = "⬅️ Recent Solve"
        startScreen.fontSize = 29.0
        startScreen.fontColor = SKColor.yellow
        startScreen.position = CGPoint(x: self.frame.midX*1.3, y: 580)
        self.addChild(startScreen)

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

            queenpos.append(0)
            queenposstart.append(0)
            let posx = CGFloat((Double(i1)*boxsize)+40.0+boxsize/2)
            let posy = CGFloat((Double(queenpos[i1])*boxsize)+120.0+boxsize/2)

            let point = CGPoint(x: posx, y: posy)
            putChess(at: point, csize: CGFloat(boxsize), imagename: "queen.png", chessname: "queen")
            
        }
        
        gameStatus = .running
    }
    
    func gameOver()  {
        
        //over
        
        gameStatus = .over
        
    }
    
    func movequeens()  {
        
        
    }
    
    
    
    

        
         
        
        
        //addLinewiseShape()
        
        
        
        // let Str_ButtonName = "button";
}

