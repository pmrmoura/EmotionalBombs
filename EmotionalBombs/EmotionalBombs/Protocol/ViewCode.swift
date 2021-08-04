//
//  ViewCode.swift
//  EmotionalBombs
//
//  Created by Pedro Moura on 26/07/21.
//

import Foundation

protocol ViewCode {
    func addSubViews()
    func setupContraints()
    func setupAdditionalConfiguration()
    func setupView()
}

extension ViewCode {
    func setupView() {
        addSubViews()
        setupContraints()
        setupAdditionalConfiguration()
    }
}
