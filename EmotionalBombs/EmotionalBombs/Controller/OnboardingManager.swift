//
//  OnboardingManager.swift
//  EmotionalBombs
//
//  Created by Juliano Vaz on 10/08/21.
//

import Foundation

class StorageOnboarding {
    
    enum Key: String{
        case onboardingSeen
    }
    
    func isOnboardingSeen() -> Bool {
        UserDefaults.standard.bool(forKey: Key.onboardingSeen.rawValue)
    }
    
    func setOnboardingSeen(){
        UserDefaults.standard.setValue(true, forKey: Key.onboardingSeen.rawValue)
    }
    
    func resetOnboardingSeen() {
        UserDefaults.standard.setValue(false, forKey: Key.onboardingSeen.rawValue)
    }
    
    
}
