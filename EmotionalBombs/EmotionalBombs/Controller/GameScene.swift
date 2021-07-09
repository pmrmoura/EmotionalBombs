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
    override func didMove(to view: SKView) {
        print("Scene loaded")
        
        self.scene?.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        
        if let background = self.scene?.childNode(withName: "backGround"){
            self.background = background as! SKSpriteNode
            let act = SKAction.colorize(with: UIColor.black, colorBlendFactor: 1, duration: 5)
            self.background.run(act)
        }
        if let playerBody = self.scene?.childNode(withName: "player") as? SKSpriteNode{
            player = Player(body: playerBody)
        }
        if let camera = self.scene?.childNode(withName: "camera") as? SKCameraNode{
            self.camera = camera

        }
    }
    
    public func moveInDirection(direction:MoveDirection){
        
        if direction == .right{
            print("Move to the right")
            player.moveTo(direction: .right)
            let moveRight = SKAction.move(by: CGVector(dx: 100, dy: 0), duration: 0.2)
            let repeatMove = SKAction.repeatForever(moveRight)
            self.camera?.run(repeatMove, withKey: "move")
            let act = SKAction.colorize(with: UIColor.white, colorBlendFactor: 1, duration: 5)
            self.background.run(act)
        }else if direction == .left{
            print("Move to the left")
            player.moveTo(direction: .left)
            let moveLeft = SKAction.move(by: CGVector(dx: -100, dy: 0), duration: 0.2)
            let repeatMove = SKAction.repeatForever(moveLeft)
            self.camera?.run(repeatMove, withKey: "move")
        }else if direction == .up{
            print("jump")
            player.moveTo(direction: .up)
        }
    }
    
    public func stopMove(){
        print("Stop move")
        player.stopMove()
        self.camera?.removeAction(forKey: "move")
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
}
