//
//  Player.swift
//  EmotionalBombs
//
//  Created by Luis Pereira on 08/07/21.
//

import Foundation
import SpriteKit

class Player{
    var body:SKSpriteNode?
    
    init(body:SKSpriteNode?) {
        self.body=body
    }
    
    func moveTo(direction:MoveDirection){
        
        if direction == .right{
            let moveRight = SKAction.move(by: CGVector(dx: 10, dy: 0), duration: 0.2)
            let repeatMove = SKAction.repeatForever(moveRight)
            self.body?.run(repeatMove, withKey: "move")
        }else if direction == .left{
            let moveLeft = SKAction.move(by: CGVector(dx: -10, dy: 0), duration: 0.2)
            let repeatMove = SKAction.repeatForever(moveLeft)
            self.body?.run(repeatMove, withKey: "move")
        }else if direction == .up{
            self.body?.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 500))
        }
    }
    
    func stopMove(){
        self.body?.removeAction(forKey: "move")
    }
}
