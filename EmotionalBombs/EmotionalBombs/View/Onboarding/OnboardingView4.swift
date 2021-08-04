//
//  OnboardingView4.swift
//  EmotionalBombs
//
//  Created by Pedro Moura on 03/08/21.
//

import UIKit

class OnboardingView4: UIView, ViewCode {
    lazy var title: UITextView = UITextView()
    lazy var backgroundImage = UIImageView()
    lazy var spiritSV = UIStackView()
    lazy var memorieImageView: UIImageView = UIImageView()
    lazy var treeImageView: UIImageView = UIImageView()
    lazy var treesView: UIView = UIView()
    lazy var memorieView: UIView = UIView()
    
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
        
        self.spiritSV.addArrangedSubview(memorieView)
        self.spiritSV.addArrangedSubview(treesView)
        
        self.treesView.addSubview(treeImageView)
        self.memorieView.addSubview(memorieImageView)
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            
            self.title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 80),
            self.title.topAnchor.constraint(equalTo: self.topAnchor, constant: 150),
            self.title.trailingAnchor.constraint(equalTo: self.centerXAnchor),
            self.title.widthAnchor.constraint(equalToConstant: 200),
            self.title.heightAnchor.constraint(equalToConstant: 100),
            
            self.spiritSV.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 50),
            self.spiritSV.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.spiritSV.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            self.memorieImageView.widthAnchor.constraint(equalToConstant: 400),
            self.memorieImageView.heightAnchor.constraint(equalToConstant: 400),
            self.memorieImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.memorieImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            self.treeImageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            self.treeImageView.heightAnchor.constraint(equalToConstant: 500),
            self.treeImageView.topAnchor.constraint(equalTo: self.memorieImageView.bottomAnchor, constant: -150),
            self.treeImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.backgroundImage.heightAnchor.constraint(equalTo: self.heightAnchor),
            self.backgroundImage.widthAnchor.constraint(equalTo: self.widthAnchor),
            
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .clear
    
        backgroundImage.image = UIImage(named: "FundoClaro.png")
        backgroundImage.contentMode =  .scaleAspectFill
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        self.title.translatesAutoresizingMaskIntoConstraints = false
        let text: String = "Recupere as memórias da conexão afetiva entre todos os seres vivos".localized()
        self.title.backgroundColor = .clear
        self.title.textColor = .white
        self.title.font = UIFont(name: "Poppins-SemiBold", size: 32)
        self.title.typeOn(string: text)
        
        self.spiritSV.translatesAutoresizingMaskIntoConstraints = false
        self.spiritSV.axis = .vertical
        
        self.memorieImageView.translatesAutoresizingMaskIntoConstraints = false
        self.memorieImageView.image = UIImage(named: "memoria")
        
        self.treeImageView.translatesAutoresizingMaskIntoConstraints = false
        self.treeImageView.image = UIImage(named: "OtaArvores")
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1.0, delay: 1.0, options: .curveEaseIn, animations: {
//                self.spiritEyeView.alpha = 1
            }, completion: nil)
        }
    }
}

