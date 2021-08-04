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
    lazy var treeBirdSV = UIStackView()
    lazy var spiritView = UIView()
    lazy var backgroundCutView = UIView()
    lazy var spiritImageView: UIImageView = UIImageView()
    lazy var backgroundCut: UIImageView = UIImageView()
    
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

        self.spiritSV.addArrangedSubview(spiritView)
        self.spiritSV.addArrangedSubview(treeBirdSV)
        
        self.treeBirdSV.addArrangedSubview(backgroundCutView)
        
        self.spiritView.addSubview(spiritImageView)
        self.backgroundCutView.addSubview(backgroundCut)
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            
            self.title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 80),
            self.title.topAnchor.constraint(equalTo: self.topAnchor, constant: 150),
            self.title.trailingAnchor.constraint(equalTo: self.centerXAnchor),
            self.title.widthAnchor.constraint(equalToConstant: 30),
            self.title.heightAnchor.constraint(equalToConstant: 120),
            
            self.spiritSV.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 100),
            self.spiritSV.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            self.spiritSV.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.spiritSV.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            self.treeBirdSV.widthAnchor.constraint(equalToConstant: 1000),
            
            self.spiritImageView.widthAnchor.constraint(equalToConstant: 800),
            self.spiritImageView.heightAnchor.constraint(equalToConstant: 700),
            
            self.backgroundCut.widthAnchor.constraint(equalToConstant: 600),
            self.backgroundCut.heightAnchor.constraint(equalToConstant: 800),
            self.backgroundCut.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 50),
            self.backgroundCut.topAnchor.constraint(equalTo: self.topAnchor, constant: -20),
            
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
        let text: String = "Agora Gaia, mãe da natureza, lhe chama para explorar o mundo".localized()
        self.title.backgroundColor = .clear
        self.title.textColor = .white
        self.title.font = UIFont(name: "Poppins-SemiBold", size: 27)
        self.title.typeOn(string: text)
        
        self.spiritSV.translatesAutoresizingMaskIntoConstraints = false
        self.spiritSV.axis = .horizontal
        
        self.spiritView.translatesAutoresizingMaskIntoConstraints = false
        
        self.spiritImageView.translatesAutoresizingMaskIntoConstraints = false
        self.spiritImageView.image = UIImage(named: "Gaia")
        self.spiritImageView.alpha = 0
        
        self.backgroundCut.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundCutView.translatesAutoresizingMaskIntoConstraints = false

        self.backgroundCut.image = UIImage(named: "CenarioCortado")
        self.backgroundCut.alpha = 0
        
        self.treeBirdSV.axis = .vertical
        self.treeBirdSV.translatesAutoresizingMaskIntoConstraints = false
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 2.0, delay: 1.5, options: .curveEaseIn, animations: {
                self.spiritImageView.alpha = 1
            }, completion: {_ in
                UIView.animate(withDuration: 2.0, delay: 1.0, options: .curveEaseIn, animations: {
                    self.backgroundCut.alpha = 1
                }, completion: nil)
            })
        }
    }
}

