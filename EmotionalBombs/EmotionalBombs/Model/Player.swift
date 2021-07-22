//
//  Player.swift
//  EmotionalBombs
//
//  Created by Luis Pereira on 08/07/21.
//

import Foundation
import SpriteKit

class Player:SKNode{
    var body:SKSpriteNode?
    var walkingFrames: [SKTexture]
    
    init(body:SKSpriteNode?, walkingFrames:[SKTexture]  ) {
        self.walkingFrames = []
        self.body = body
        super.init()
       
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.walkingFrames = []
        super.init()
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveTo(direction:MoveDirection){
        
        if direction == .right{
            let moveRight = SKAction.move(by: CGVector(dx: 100, dy: 0), duration: 0.2)
            let repeatMove = SKAction.repeatForever(moveRight)
            self.body?.run(repeatMove, withKey: "move")
        }else if direction == .left{
            let moveLeft = SKAction.move(by: CGVector(dx: -100, dy: 0), duration: 0.2)
            let repeatMove = SKAction.repeatForever(moveLeft)
            self.body?.run(repeatMove, withKey: "move")
        }else if direction == .up{
            self.body?.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 1000))
        }
    }
    
    func stopMove(){
        self.body?.removeAction(forKey: "move")
        self.body?.removeAction(forKey: "walkingInPlacePlayer")
    }
    
     func buildAnimationWalkingRight(){
        for i in 4...9 { //numImages
            self.walkingFrames.append(SKTexture(imageNamed: "EspiritoGaiaAnimacao_0000\(i)"))
        }
    }
        
     func animatePlayer() {
        self.body?.run(SKAction.repeatForever(
                    SKAction.animate(with: walkingFrames,
                                     timePerFrame: 0.1,
                                     resize: true,
                                     restore: false)),
                   withKey:"walkingInPlacePlayer")
    }
}
