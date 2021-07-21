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

class GameScene: SKScene {
    
    var background = SKSpriteNode(imageNamed: "background.jpg")
    var player = Player(body:nil, walkingFrames: [])
    var readyToUpdate = false
    var jointHappened = false
    var jt: SKPhysicsJointLimit?
    var goingLeft = false
    
    override func didMove(to view: SKView){
        print("Scene loaded")
        player.isUserInteractionEnabled = true
        self.scene?.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        
        createBackground()
        
        if let background = self.scene?.childNode(withName: "background.jpeg"){
            self.background = background as! SKSpriteNode
        }
        if let playerBody = self.scene?.childNode(withName: "player") as? SKSpriteNode{
            player = Player(body: playerBody, walkingFrames: [])
        }
        player.buildAnimationWalkingRight()
        
        if let camera = self.scene?.childNode(withName: "camera") as? SKCameraNode{
            self.camera = camera
        }
    }
    
    func createBackground() {
        for i in 0...2 {
            let background = SKSpriteNode(imageNamed: "background\(i).png")
            background.name = "background"
            background.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!)
            background.position = CGPoint(x: CGFloat(i) * background.size.width , y: (self.frame.size.height / 32))
            background.zPosition = -10
            self.addChild(background)
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
                    print("bird pressed")
                    SKAction
                }
                
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval){
        self.camera?.position.x = (player.body?.position.x)!
        if goingLeft && (player.body?.position.x)! <= 100 {
            player.stopMove()
        }
    }
}


//Player Moviment extension
extension GameScene{
    
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

