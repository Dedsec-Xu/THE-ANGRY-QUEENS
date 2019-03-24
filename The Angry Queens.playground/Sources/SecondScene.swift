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
    public var maxround = 100
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
    var animationdone = true
    var calciter = 0
    var solves = 0
    var Foundtext = SKLabelNode(fontNamed: "Helvetica")
    var SolveDisp = [SKLabelNode]()
    var Finished = 0
    
    
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
                gameStatus = .running
            case .running:
                tryall()
                gameStatus = .over
            
            case .over:
                gameStatus = .over
        }
    }
    
//    func calculatenext(){
//
//    }
    
    func tryall() {
        print("tryall")
        print(queenpos.endIndex)
        queenpos[iterk-1] += 1
        for i in 1...(iterk){
            if queenpos[iterk-i] >= iterk{
                print("[\(i)] = 0")
                if iterk-i-1>=0{                    
                    queenpos[iterk-i] = 0
                    queenpos[iterk-i-1] = queenpos[iterk-i-1]+1 
                }
            }
        }
        animationdone = false
        if queenpos[0]==(iterk){
            Finished = 1;
            calciter = maxround+1
        
            movequeens()
            
        }
        else{
            movequeens()
            
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
        BGM.play()
//        let action = SKAction.playSoundFileNamed("It_Devours.mp3", waitForCompletion: false)
//        self.run(action)
        

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
            putChess(at: point, csize: CGFloat(boxsize), imagename: "queen.png", chessname: "queen")
        }
        
        gameStatus = .running
    }
    
    func gameOver()  {
        
        //over
        
        gameStatus = .over
        
    }
    
    func movequeens()  {
         checkviable()
        //over
        for i in 0..<iterk{
            print(i)
            let posx = CGFloat((Double(i)*boxsize)+40.0+boxsize/2)
            let posy = CGFloat((Double(queenpos[i]%iterk)*boxsize)+120.0+boxsize/2)
            let point = CGPoint(x: posx, y: posy)
            let move1 = SKAction.move(to: point, duration: (Double(waitt)/1000))
            if i==iterk-1{
                queens[i].run(move1,completion:{
                    self.Finishanimation()
                })
            }else{
                queens[i].run(move1)
            }
            
        }
        
    }
    
    func Finishanimation(){
        animationdone = true
        print(Finishanimation)
        if calciter < maxround && Finished == 0{
            tryall()
            calciter = calciter+1
        }else if Finished == 1{
            
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
            let action = SKAction.playSoundFileNamed("Yay.mp3", waitForCompletion: false)
            self.run(action)
            
        }else if calciter >= maxround{
            
            let Node_Background = SKSpriteNode(imageNamed: "loop.png")
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
    }
    
    
    func checkviable(){
        var endcheck = 0
        
        for i in 0..<(queenpos.endIndex-1){
            if endcheck == 1{
                break
            }else{
                for j in (i+1)..<queenpos.endIndex{
                    if queenpos[i] == queenpos[j]{
                        print("pos \(i) = pos \(j)")
                        endcheck = 1
                        break
                    }else if abs(queenpos[i]-queenpos[j])==abs(i-j){
                        
                        print("abs \(i) = abs \(j)")
                        endcheck = 1
                        break
                    }
                }
            }
        }
        if endcheck == 0{
            
            for i in 0..<iterk{
                var TempString = ""
                for j in 0..<iterk{
                    if queenpos[j]==(iterk-i-1){
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
            
            Foundtext.text = "Found \(solves) Solves"
        }
    }
        //addLinewiseShape()
        // let Str_ButtonName = "button";
}
