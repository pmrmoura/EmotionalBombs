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
    
    var player = Player(body:nil)
    var background = SKSpriteNode()
    var readyToUpdate = false
    var jointHappened = false
    var jt: SKPhysicsJointLimit?
    
    override func didMove(to view: SKView){
        print("Scene loaded")
        player.isUserInteractionEnabled = true
        self.scene?.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        
        if let background = self.scene?.childNode(withName: "backGround"){
            self.background = background as! SKSpriteNode
        }
        if let playerBody = self.scene?.childNode(withName: "player") as? SKSpriteNode{
            player = Player(body: playerBody)
        }
        if let camera = self.scene?.childNode(withName: "camera") as? SKCameraNode{
            self.camera = camera
            
        }
    }
     
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let firstTouch = touches.first{
            print("touch began at \(firstTouch.location(in: self.scene!))")
        }
    }
    
    func hitValidation(location:CGPoint){
        print("hitValidation received \(location)")
        if let nodes = self.scene?.nodes(at: location){
            for node in nodes{
                if !jointHappened{
                    if node.name! == "moveble"{ //tem que generalizar aqui depois
                        node.physicsBody?.isDynamic = true
                        node.physicsBody?.affectedByGravity = true
                        jt = SKPhysicsJointLimit.joint(withBodyA: (player.body?.physicsBody)!, bodyB: node.physicsBody!, anchorA: player.body!.position, anchorB: node.position)
                        self.scene?.physicsWorld.add(jt!)
                        print("Joint added")
                    }
                }
                if jointHappened{
                    node.physicsBody?.isDynamic = false
                    node.physicsBody?.affectedByGravity = false
                    self.scene?.physicsWorld.remove(jt!)
                    print("Joint removed")
                }
                self.jointHappened.toggle()
            }
        }
    }
    override func update(_ currentTime: TimeInterval){
        self.camera?.position.x = (player.body?.position.x)!
    }
}


//Moviment extension
extension GameScene{
    
    public func moveInDirection(direction:MoveDirection){
        
        if direction == .right{
            print("Move to the right")
            player.moveTo(direction: .right)
        }else if direction == .left{
            print("Move to the left")
            player.moveTo(direction: .left)
        }else if direction == .up{
            print("jump")
            player.moveTo(direction: .up)
        }
        
    }
    
    public func stopMove(){
        print("Stop move")
        player.stopMove()
    }
}