//
//  String.swift
//  EmotionalBombs
//
//  Created by Pedro Moura on 26/07/21.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
