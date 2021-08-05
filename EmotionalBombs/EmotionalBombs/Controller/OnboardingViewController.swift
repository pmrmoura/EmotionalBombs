//
//  OnboardingViewController.swift
//  EmotionalBombs
//
//  Created by Pedro Moura on 26/07/21.
//

import UIKit
import AVFoundation

class OnboardingViewController: UIViewController {
    
    private var audioPlayer: AVAudioPlayer?
    
    override func loadView() {
        self.view = UIView()
    }
    
    override func viewDidLoad() {
       viewChanges()
    }
    
    
    func viewChanges() {
        let viewArray = [OnboardingView.self, OnboardingView2.self, OnboardingView3.self, OnboardingView4.self, OnboardingView5.self]
        var characterIndex = 0
        var lastView: UIView = UIView()
        
        DispatchQueue.main.async {
            self.audioBackground() //settings
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 8) {
            self.audioPlayer?.play()
        }

        
        Timer.scheduledTimer(withTimeInterval: 8, repeats: true) { (timer) in
            if characterIndex > 0 {
                UIView.animate(withDuration: 2.0, animations: {
                    lastView.alpha = 0
                    lastView.removeFromSuperview()
                })
            }
            if characterIndex < viewArray.count {
                let nextView:UIView = viewArray[characterIndex].init() as UIView
                nextView.frame = UIScreen.main.bounds
                self.view.addSubview(nextView)
                characterIndex += 1
                lastView = nextView
            } else {
                characterIndex += 1
            }
            if characterIndex == viewArray.count + 1{
                timer.invalidate()
                self.audioPlayer?.stop()
                self.navigationController?.pushViewController(GameViewController(), animated: true)
            }
        }
       
    }
   
    func audioBackground() {
        let soundEffect = Bundle.main.path(forResource: "onboarding-song", ofType: "mp3")
        let url2 = URL(fileURLWithPath: soundEffect!)
        audioPlayer = AVAudioPlayer()
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url2)
            audioPlayer?.prepareToPlay()
        } catch{
            print(" deu pau no audio")
        }
    }
}
