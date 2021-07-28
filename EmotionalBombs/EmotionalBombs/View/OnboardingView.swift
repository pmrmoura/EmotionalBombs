//
//  OnboardingView.swift
//  EmotionalBombs
//
//  Created by Pedro Moura on 26/07/21.
//

import UIKit

class OnboardingView: UIView, ViewCode {
    lazy var title: UILabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubViews() {
        self.addSubview(title)
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            self.title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.title.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .systemBlue
        
        self.title.translatesAutoresizingMaskIntoConstraints = false
        self.title.text = "Acorde, espírito do tempo, recupere uma vida secreta por trás dos seres da natureza".localized()
        self.title.font = UIFont.systemFont(ofSize: 32, weight: .thin)
    }
}
