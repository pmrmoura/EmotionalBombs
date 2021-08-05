//
//  GameScene.swift
//  EmotionalBombs
//
//  Created by Luis Pereira on 08/07/21.
//
enum MoveDirection {
    case right
    case left
    case up
}

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player = Player(body:nil, walkingFrames: [])
    var jointHappened = false
    var jt: SKPhysicsJointLimit?
    var goingLeft = false
    private var audioPlayer: AVAudioPlayer?
    private var audioPlayer2: AVAudioPlayer?
    var birdFlew = false
    var sawFirstPuzzle = false
    var puzzleSolved = false
    var jumping = false
    var playedBackgroundSound = false
    
    var controllerDelegate: GameSceneDelegate?
    
    override func didMove(to view: SKView){
        print("Scene loaded")
        
        player.isUserInteractionEnabled = true
        self.scene?.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        self.scene?.physicsWorld.contactDelegate = self
        
        //        if let background = self.scene?.childNode(withName: "background") as? SKSpriteNode{
        //            let darkBackground = SKAction.colorize(with: .black, colorBlendFactor: 0.7, duration: 0.1)
        //            background.run(darkBackground)
        //        }
        
        if let playerBody = self.scene?.childNode(withName: "player") as? SKSpriteNode{
            player = Player(body: playerBody, walkingFrames: [])
        }
        player.buildAnimationWalkingRight()
    
        if let camera = self.scene?.childNode(withName: "camera") as? SKCameraNode{
            self.camera = camera
        }
        
        //build
        audioBackground()
        
        if self.childNode(withName: "player") != nil{
            print("entrou player existe")
            if !playedBackgroundSound{
                print("entrou player existe e tocou")
                self.audioPlayer2?.play()
                playedBackgroundSound = true
            }
        }
        
        
    }
    
    fileprivate func audioBackground() {
        let soundEffect2 = Bundle.main.path(forResource: "gameplayTestVolumeBaixo", ofType: "mp3")
        let url2 = URL(fileURLWithPath: soundEffect2!)
        audioPlayer2 = AVAudioPlayer()
        
        do {
            audioPlayer2 = try AVAudioPlayer(contentsOf: url2)
            audioPlayer2?.prepareToPlay()
        } catch{
            print(" deu pau no audio")
        }
    }
    
    fileprivate func audioTouchInTheMemory() {
        let soundEffect = Bundle.main.path(forResource: "effect", ofType: "mp3")
        let url = URL(fileURLWithPath: soundEffect!)
        audioPlayer = AVAudioPlayer()
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
        } catch{
            print(" deu pau no audio")
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {

        //build
        audioTouchInTheMemory()

        print("entrou no begin do contatooo")
        if contact.bodyA.node?.name == "luz" || contact.bodyA.node?.name == "player"  {
           if contact.bodyB.node?.name == "luz" || contact.bodyB.node?.name == "player" {
                let scaleLightMemory = SKAction.scale(by: 1.3, duration: 1)
                let fadeOutLightMemory = SKAction.fadeOut(withDuration:1)
                if let luzNode = self.childNode(withName: "luz") {
                    self.audioPlayer?.play()
                    luzNode.run(SKAction.sequence([scaleLightMemory,fadeOutLightMemory]), completion: {
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                            luzNode.removeFromParent()
                        }
                    })
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        self.audioPlayer?.stop()
                        self.audioPlayer2?.stop()
                        self.controllerDelegate?.navigateToDragView()
                    }
                }
            }
        }
    }
    
    func scrollBackground(){
        self.enumerateChildNodes(withName: "background", using: ({
            (node, error) in
            // 1
            node.position.x -= 4
            print("node position x = \(node.position.x)")
            // 2
            if node.position.x < -(self.scene?.size.width)! {
                node.position.x += (self.scene?.size.width)! * 3
            }
        }))
    }
    
    func hitValidation(location:CGPoint){
        
        if let nodes = self.scene?.nodes(at: location){
            for node in nodes{
                if node.name! == "moveble"{
                    moveBox(node: node)
                }
                else if node.name! == "bird"{
                    birdFly(node: node)
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval){
        
        if(!sawFirstPuzzle || puzzleSolved){
            self.camera?.position.x = (player.body?.position.x)!
            self.camera?.position.y = (player.body?.position.y)! + 350
        }
        
        if goingLeft && (player.body?.position.x)! <= 100 {
            player.stopMove()
        }
        
        if (player.body?.position.x)! > 2800 && !sawFirstPuzzle{
            let moveTo = SKAction.move(to: CGPoint(x: 3800, y: 500), duration: 2)
            let zoomOut = SKAction.scale(by: 2, duration: 2)
            self.camera?.run(moveTo)
            self.camera?.run(zoomOut)
            sawFirstPuzzle = true
        }
    }
}




//Player Moviment extension
extension GameScene{
    
    func memoryLightAnimation(){
        
        if let node = self.scene?.childNode(withName: "luz"){
            
            var spinning:[SKTexture] = []
            
            for i in 0...13{
                let texture = SKTexture(imageNamed: "MemoriaGaia_0000\(i)")
                
                spinning.append(texture)
            }
            
            let memoryLightSpinning = SKAction.animate(with: spinning, timePerFrame: 0.1, resize: false, restore: true)
            node.run(SKAction.setTexture(SKTexture(imageNamed: "MemoriaGaia_00000"),resize: false))
            node.run(SKAction.repeatForever(memoryLightSpinning), withKey: "spinningForever")
        }
    }
    
  
    func sawBirdOnScreen(){
        
        if let node = self.scene?.childNode(withName: "bird"){
            
            var flying:[SKTexture] = []
            
            for i in 2...11{
                let texture = SKTexture(imageNamed: "AraraGaiaAnimacao_0000\(i)")
                flying.append(texture)
            }
                
            let animateFlyingStucked = SKAction.animate(with: flying, timePerFrame: 0.1)
            node.run(SKAction.setTexture(SKTexture(imageNamed: "AraraGaiaAnimacao_00000"),resize: true))
            node.run(SKAction.repeatForever(animateFlyingStucked), withKey: "birdFlyingStucked")
        }
    }
    
    func birdFly(node:SKNode){
        player.body?.physicsBody?.affectedByGravity = false
        player.body?.physicsBody?.isDynamic = false
        print("bird pressed")
        self.birdFlew = true
        node.removeAction(forKey: "birdFlyingStucked")
        
        var flying2getherToLight:[SKTexture] = []
        for i in 0...13{
            let texture = SKTexture(imageNamed: "Arara_Personagem_Animar_0000\(i)")
            flying2getherToLight.append(texture)
        }
        
        var birdFlyingToPlayer:[SKTexture] = []
        for i in 0...13{
            let texture = SKTexture(imageNamed: "AraraGaiaAnimacao_0000\(i)")
            birdFlyingToPlayer.append(texture)
        }
        
    
        let birdGoUp = SKAction.moveTo(y: 764.244, duration: 2)
        let animateFlyingUp = SKAction.animate(with: birdFlyingToPlayer, timePerFrame: 0.1)
        node.run(SKAction.setTexture(SKTexture(imageNamed: "AraraGaiaAnimacao_00000"),resize: true))
        node.run(SKAction.repeatForever(animateFlyingUp), withKey: "flyingUp")
        
        node.run(birdGoUp,completion: {
            
            let jumpOnBird = SKAction.move(by: CGVector(dx: 40, dy: 40), duration: 0.2)
            let moveToBird = SKAction.move(to: node.position, duration: 0.5)
            let seq = SKAction.sequence([jumpOnBird,moveToBird])
            
            self.player.body?.run(seq,completion: {
                
                node.removeAction(forKey: "flyingUp")
                
                self.player.body?.alpha = 0.0
                
                node.run(SKAction.setTexture(SKTexture(imageNamed: "Arara_Personagem_Animar_00000"),resize: true))
                let moveToOtherSide = SKAction.move(to: CGPoint(x: 5000, y: 820), duration: 4.0)
                let animateFly = SKAction.animate(with: flying2getherToLight, timePerFrame: 0.1)
                
                node.run(SKAction.repeatForever(animateFly),withKey: "flying")
                node.run(moveToOtherSide)
                self.player.body?.run(moveToOtherSide,completion: {
                    
                    node.removeAllActions()
                    var birdFlyingToPlayer:[SKTexture] = []
                    for i in 0...13{
                        let texture = SKTexture(imageNamed: "AraraGaiaAnimacao_0000\(i)")
                        birdFlyingToPlayer.append(texture)
                    }
                    let birdGoBack = SKAction.move(to: CGPoint(x: 3029.716, y: -105.376), duration: 3)
                    let animateFlyingUp = SKAction.animate(with: birdFlyingToPlayer, timePerFrame: 0.1)
                    node.run(SKAction.setTexture(SKTexture(imageNamed: "AraraGaiaAnimacao_00000"),resize: true))
                    node.run(SKAction.repeatForever(animateFlyingUp), withKey: "flyingUp")
                    let seq = SKAction.sequence([SKAction.wait(forDuration: 2),SKAction.scaleX(to: -1, duration: 0.0),birdGoBack])
                    node.run(seq, completion: {node.removeAllActions()})
                    self.puzzleSolved = true
                    let zoomIn = SKAction.scale(by: 1/2, duration: 2)
                    self.camera?.run(zoomIn)
                    self.player.body?.physicsBody?.affectedByGravity = true
                    self.player.body?.physicsBody?.isDynamic = true
                    
                    self.player.body?.position.x = 5000
                    self.player.body?.position.y = 800
                    self.player.body?.alpha = 1.0
                    
                    self.memoryLightAnimation()
   
                })
            })
        })
    
       
    }
    
    func moveBox(node:SKNode){
        if !jointHappened{
            let blockAction = SKAction.run({
                node.physicsBody?.isDynamic = true
                node.physicsBody?.affectedByGravity = true
                self.jt = SKPhysicsJointLimit.joint(withBodyA: (self.player.body?.physicsBody)!, bodyB: node.physicsBody!, anchorA: self.player.body!.position, anchorB: node.position)
                self.scene?.physicsWorld.add(self.jt!)
                print("Joint added")
                self.jointHappened.toggle()
            })
            self.scene?.run(blockAction)
        
   
        }
        else {
            let blockAction = SKAction.run({
                node.physicsBody?.isDynamic = false
                node.physicsBody?.affectedByGravity = false
                self.scene?.physicsWorld.remove(self.jt!)
                print("Joint removed")
                self.jointHappened.toggle()
            })
            self.scene?.run(blockAction)
        }
    }
    
    public func moveInDirection(direction:MoveDirection){
        
        if direction == .right{
            player.body?.xScale = abs(player.body!.xScale) * 1.0
            print("Move to the right")
            player.moveTo(direction: .right)
            scrollBackground()
            goingLeft = false
            
        }else if direction == .left{
            player.body?.xScale = abs(player.body!.xScale) * -1.0
            if (player.body?.position.x)! >= 100 {
                print("Move to the left", player.body?.position.x as Any)
                player.moveTo(direction: .left)
                goingLeft = true
                
            }
        }else if direction == .up && !jumping{
            jumping =  true
            self.player.moveTo(direction: .up)
            print("jumped")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
                self.jumping = false
            }
        }
        
        if !jointHappened{
            self.player.animatePlayer()
        }
        else if direction == .left || direction == .right {
            self.player.pushTheBoxAnimation()
        }
    }
    
    public func stopMove(){
        print("Stop move")
        player.stopMove()
        if let node = self.scene?.childNode(withName: "moveble"){
            print("moveble está na cena \(node.position)")
        }else{
            print("n estah na cena")
        }
    }
}

