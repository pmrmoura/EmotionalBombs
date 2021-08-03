//
//  String.swift
//  EmotionalBombs
//
//  Created by Pedro Moura on 26/07/21.
//

import UIKit

extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
    
    var characterArray: [Character]{
        var characterArray = [Character]()
        for character in self {
            characterArray.append(character)
        }
        return characterArray
    }
}

extension UITextView {
    func typeOn(string: String) {
        let characterArray = string.characterArray
        var characterIndex = 0
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            self.text.append(characterArray[characterIndex])
            characterIndex += 1
            if characterIndex == characterArray.count {
                timer.invalidate()
            }
        }
    }
}
