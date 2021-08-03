//
//  OnboardingView3.swift
//  EmotionalBombs
//
//  Created by Pedro Moura on 03/08/21.
//

import UIKit

class OnboardingView3: UIView, ViewCode {
    lazy var title: UITextView = UITextView()
    lazy var backgroundImage = UIImageView()
    lazy var spiritSV = UIStackView()
    lazy var spiritImageView: UIImageView = UIImageView()
    lazy var spiritEyeView: UIView = UIView()
    lazy var spiritEyeIV: UIImageView = UIImageView()
    
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
        
        self.spiritEyeView.addSubview(spiritEyeIV)
    
        self.spiritSV.addArrangedSubview(spiritEyeView)
        self.spiritSV.addArrangedSubview(spiritImageView)
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            
            self.title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 80),
            self.title.topAnchor.constraint(equalTo: self.topAnchor, constant: 150),
            self.title.trailingAnchor.constraint(equalTo: self.centerXAnchor),
            self.title.widthAnchor.constraint(equalToConstant: 200),
            self.title.heightAnchor.constraint(equalToConstant: 80),
            
            self.spiritSV.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 30),
            self.spiritSV.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.spiritSV.widthAnchor.constraint(equalToConstant: 400),
            
            self.spiritImageView.widthAnchor.constraint(equalToConstant: 400),
            self.spiritImageView.heightAnchor.constraint(equalToConstant: 800),
            
            self.spiritEyeIV.widthAnchor.constraint(equalToConstant: 110),
            self.spiritEyeIV.heightAnchor.constraint(equalToConstant: 35),
            self.spiritEyeIV.centerXAnchor.constraint(equalTo: self.spiritEyeView.centerXAnchor, constant: -10),
            self.spiritEyeIV.topAnchor.constraint(equalTo: self.spiritSV.topAnchor, constant: 100),
            
            self.backgroundImage.heightAnchor.constraint(equalTo: self.heightAnchor),
            self.backgroundImage.widthAnchor.constraint(equalTo: self.widthAnchor),
            
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .clear
    
        backgroundImage.image = UIImage(named: "FundoEscuro.png")
        backgroundImage.contentMode =  .scaleAspectFill
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        self.title.translatesAutoresizingMaskIntoConstraints = false
        let text: String = "Acorde, espírito do tempo".localized()
        self.title.backgroundColor = .clear
        self.title.textColor = .white
        self.title.font = UIFont(name: "Poppins-SemiBold", size: 32)
        self.title.typeOn(string: text)
        
        self.spiritSV.translatesAutoresizingMaskIntoConstraints = false
        self.spiritSV.axis = .vertical
        self.spiritSV.bringSubviewToFront(spiritEyeView)
        
        self.spiritImageView.translatesAutoresizingMaskIntoConstraints = false
        self.spiritImageView.image = UIImage(named: "EspritoSemOlho")
        
        self.spiritEyeIV.translatesAutoresizingMaskIntoConstraints = false
        self.spiritEyeIV.image = UIImage(named: "olhos")

        self.spiritEyeView.alpha = 0
        self.spiritEyeView.translatesAutoresizingMaskIntoConstraints = false
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1.0, delay: 1.0, options: .curveEaseIn, animations: {
                self.spiritEyeView.alpha = 1
            }, completion: nil)
        }
    }
}

