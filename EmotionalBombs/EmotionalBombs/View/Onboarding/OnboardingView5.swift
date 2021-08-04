//
//  OnboardingView5.swift
//  EmotionalBombs
//
//  Created by Pedro Moura on 03/08/21.
//

import UIKit

class OnboardingView5: UIView, ViewCode {
    lazy var title: UITextView = UITextView()
    lazy var backgroundImage = UIImageView()
    lazy var spiritSV = UIStackView()
    lazy var spiritImageView: UIImageView = UIImageView()
    
    init() {
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubViews() {
    
        self.addSubview(backgroundImage)
        self.addSubview(title)
        self.addSubview(spiritSV)
        
        self.spiritSV.addArrangedSubview(spiritImageView)
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            
            self.spiritSV.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.spiritSV.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.spiritSV.widthAnchor.constraint(equalToConstant: 400),
            
            self.spiritImageView.widthAnchor.constraint(equalToConstant: 400),
            self.spiritImageView.heightAnchor.constraint(equalToConstant: 400),
            self.spiritImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.spiritImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -50),
            
            self.title.topAnchor.constraint(equalTo: self.spiritSV.bottomAnchor),
            self.title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.title.widthAnchor.constraint(equalToConstant: 280),
            self.title.heightAnchor.constraint(equalToConstant: 100),
            
            self.backgroundImage.heightAnchor.constraint(equalTo: self.heightAnchor),
            self.backgroundImage.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 300),
            
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .clear
    
        backgroundImage.image = UIImage(named: "FundoPlay.png")
        backgroundImage.contentMode =  .scaleAspectFill
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        self.title.translatesAutoresizingMaskIntoConstraints = false
        let text: String = "Gaia's Memories".localized()
        self.title.text = text
        self.title.backgroundColor = .clear
        self.title.textColor = UIColor(named: "TitleColor")
        self.title.font = UIFont(name: "Poppins-SemiBold", size: 27)
        self.title.alpha = 0
        
        self.spiritSV.translatesAutoresizingMaskIntoConstraints = false
        self.spiritSV.axis = .vertical
        
        self.spiritImageView.translatesAutoresizingMaskIntoConstraints = false
        self.spiritImageView.image = UIImage(named: "EstrelaFinal")
        self.spiritImageView.alpha = 0
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 5.0, delay: 2.0, options: .curveEaseIn, animations: {
                self.title.alpha = 1
                self.spiritImageView.alpha = 1
            }, completion: nil)
        }
    }
}

