//
//  GameViewController.swift
//  EmotionalBombs
//
//  Created by Luis Pereira on 08/07/21.
//

import UIKit
import SpriteKit
import GameplayKit

protocol GameSceneDelegate {
    func navigateToDragView()
}

class GameViewController: UIViewController, GameSceneDelegate {
    func navigateToDragView() {
        self.navigationController?.pushViewController(DragController(), animated: true)
    }
    
    var gameSecene = GameScene()
    
    override func loadView() {
        self.view = SKView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            
            if let scene = SKScene(fileNamed: "GameScene") as? GameScene{
                // Set the scale mode to scale to fit the window
                gameSecene = scene
                gameSecene.scaleMode = .aspectFill
                gameSecene.controllerDelegate = self
                // Present the scene
                let rightSwipe = UISwipeGestureRecognizer(target: self, action:#selector(swipeHandler(_:)))
                let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler(_:)))
                let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler(_:)))
                let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressHandler(_:)))
                rightSwipe.direction = .right
                rightSwipe.cancelsTouchesInView = false
                leftSwipe.direction = .left
                leftSwipe.cancelsTouchesInView = false
                upSwipe.direction = .up
                upSwipe.cancelsTouchesInView = false
                view.addGestureRecognizer(rightSwipe)
                view.addGestureRecognizer(leftSwipe)
                view.addGestureRecognizer(upSwipe)
                view.addGestureRecognizer(longPressGesture)
                view.presentScene(gameSecene)
                view.ignoresSiblingOrder = false
                self.view = view
            }
        }
    }
    
    @objc func longPressHandler(_ sender:UILongPressGestureRecognizer){
        print("Long press detected")
        if sender.state == .began{
            print("Do something in the GameSecene")
            let location = sender.location(in: self.view)
            let sceneCoordinates = gameSecene.convertPoint(fromView: location)
            print("Sending coordinates \(sceneCoordinates)")
            gameSecene.hitValidation(location:sceneCoordinates)
        }
    }
    
    @objc func swipeHandler(_ sender:UISwipeGestureRecognizer){
        if sender.direction == .right{
            print("Swipe right")
            gameSecene.moveInDirection(direction: .right)
        }else if sender.direction == .left{
            print("Swipe left")
            gameSecene.moveInDirection(direction: .left)
        }else if sender.direction == .up{
            print("Swipe up")
            gameSecene.moveInDirection(direction: .up)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touch ended")
        gameSecene.stopMove()
    }
   
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
