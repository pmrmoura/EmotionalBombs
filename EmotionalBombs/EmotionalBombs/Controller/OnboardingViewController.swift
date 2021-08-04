//
//  OnboardingViewController.swift
//  EmotionalBombs
//
//  Created by Pedro Moura on 26/07/21.
//

import UIKit

class OnboardingViewController: UIViewController {
    
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
        Timer.scheduledTimer(withTimeInterval: 8, repeats: true) { (timer) in
            if characterIndex > 0 {
                UIView.animate(withDuration: 2.0, animations: {
                    lastView.alpha = 0
                    lastView.removeFromSuperview()
                })
            }
            let nextView:UIView = viewArray[characterIndex].init() as UIView
            nextView.frame = UIScreen.main.bounds
            self.view.addSubview(nextView)
            characterIndex += 1
            lastView = nextView
            if characterIndex == viewArray.count {
                timer.invalidate()
            }
        }
    }
}
