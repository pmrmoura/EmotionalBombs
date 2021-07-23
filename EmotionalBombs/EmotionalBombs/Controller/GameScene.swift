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
    
    var background = SKSpriteNode(imageNamed: "background.jpg")
    var player = Player(body:nil, walkingFrames: [])
    var readyToUpdate = false
    var jointHappened = false
    var jt: SKPhysicsJointLimit?
    var goingLeft = false
    private var audioPlayer: AVAudioPlayer?
    
    override func didMove(to view: SKView){
        print("Scene loaded")
        player.isUserInteractionEnabled = true
        self.scene?.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        self.scene?.physicsWorld.contactDelegate = self
        
        if let background = self.scene?.childNode(withName: "background"){
            self.background = background as! SKSpriteNode
            let darkBackground = SKAction.colorize(with: .black, colorBlendFactor: 0.7, duration: 0.1)
//            self.background.run(darkBackground)
        }
        if let playerBody = self.scene?.childNode(withName: "player") as? SKSpriteNode{
            player = Player(body: playerBody, walkingFrames: [])
        }
        player.buildAnimationWalkingRight()
        
        if let camera = self.scene?.childNode(withName: "camera") as? SKCameraNode{
            self.camera = camera
        }
        
    }
  
    
    func didBegin(_ contact: SKPhysicsContact) {

        let soundEffect = Bundle.main.path(forResource: "effect", ofType: "mp3")
        let url = URL(fileURLWithPath: soundEffect!)
        audioPlayer = AVAudioPlayer()

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch{
            print(" deu pau no audio")
        }
//
        print("entrou no begin do contatooo")
        if contact.bodyA.node?.name == "luz" || contact.bodyA.node?.name == "player"  {
           if contact.bodyB.node?.name == "luz" || contact.bodyB.node?.name == "player" {
                let scaleLightMemory = SKAction.scale(by: 1.5, duration: 1)
                let fadeOutLightMemory = SKAction.fadeOut(withDuration:1)
                if let luzNode = self.childNode(withName: "luz") {
                    self.audioPlayer?.play()
                    luzNode.run(SKAction.sequence([scaleLightMemory,fadeOutLightMemory]), completion: {
                        luzNode.removeFromParent()
                    })
                    
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
        self.camera?.position.x = (player.body?.position.x)!
        //self.camera?.position.y = (player.body?.position.y)!
        if goingLeft && (player.body?.position.x)! <= 100 {
            player.stopMove()
        }
    }
}


//Player Moviment extension
extension GameScene{
    
    func birdFly(node:SKNode){
        player.body?.physicsBody?.affectedByGravity = false
        player.body?.physicsBody?.isDynamic = false
        print("bird pressed")
        
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
        
    
        let birdGoUp = SKAction.moveTo(y: 381.17, duration: 2)
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
                let moveToOtherSide = SKAction.move(to: CGPoint(x: 4110, y: 150), duration: 3.0)
                let animateFly = SKAction.animate(with: flying2getherToLight, timePerFrame: 0.1)
                
                node.run(SKAction.repeatForever(animateFly),withKey: "flying")
                node.run(moveToOtherSide)
                self.player.body?.run(moveToOtherSide,completion: {
                    node.removeAction(forKey: "flying")
                    
                    self.player.body?.physicsBody?.affectedByGravity = true
                    self.player.body?.physicsBody?.isDynamic = true
                    
                    let moveToGround = SKAction.move(to: CGPoint(x: 4110, y: 150), duration: 0.2)
                    self.player.body?.run(moveToGround)
                
                })
            })
        })
    }
    
    func moveBox(node:SKNode){
        if !jointHappened{
            node.physicsBody?.isDynamic = true
            node.physicsBody?.affectedByGravity = true
            jt = SKPhysicsJointLimit.joint(withBodyA: (player.body?.physicsBody)!, bodyB: node.physicsBody!, anchorA: player.body!.position, anchorB: node.position)
            self.scene?.physicsWorld.add(jt!)
            print("Joint added")
            self.jointHappened.toggle()
        }
        else {
            node.physicsBody?.isDynamic = false
            node.physicsBody?.affectedByGravity = false
            self.scene?.physicsWorld.remove(jt!)
            print("Joint removed")
            self.jointHappened.toggle()
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
                print("Move to the left", player.body?.position.x)
                player.moveTo(direction: .left)
                goingLeft = true
                
            }
        }else if direction == .up{
            print("jump")
            player.moveTo(direction: .up)
        }
        
        player.animatePlayer()
        
        
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

