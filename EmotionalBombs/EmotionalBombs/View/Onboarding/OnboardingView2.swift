//
//  OnboardingView2.swift
//  EmotionalBombs
//
//  Created by Pedro Moura on 03/08/21.
//

import UIKit

class OnboardingView2: UIView, ViewCode {
    lazy var title: UITextView = UITextView()
    lazy var backgroundImage = UIImageView()
    lazy var spiritSV = UIStackView()
    lazy var treeBirdSV = UIStackView()
    lazy var spiritView = UIView()
    lazy var treeView = UIView()
    lazy var birdView = UIView()
    lazy var spiritImageView: UIImageView = UIImageView()
    lazy var treeImageView: UIImageView = UIImageView()
    lazy var araraImageView: UIImageView = UIImageView()
    
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

        self.treeBirdSV.addArrangedSubview(treeView)
        self.treeBirdSV.addArrangedSubview(birdView)
        
        self.spiritView.addSubview(spiritImageView)
        self.treeView.addSubview(treeImageView)
        self.birdView.addSubview(araraImageView)
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            
            self.title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 80),
            self.title.topAnchor.constraint(equalTo: self.topAnchor, constant: 150),
            self.title.trailingAnchor.constraint(equalTo: self.centerXAnchor),
            self.title.widthAnchor.constraint(equalToConstant: 30),
            self.title.heightAnchor.constraint(equalToConstant: 120),
            
            self.spiritSV.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 200),
            self.spiritSV.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            self.spiritSV.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.spiritSV.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            self.treeBirdSV.widthAnchor.constraint(equalToConstant: 1000),
            
            self.treeImageView.widthAnchor.constraint(equalToConstant: 1000),
            self.treeImageView.heightAnchor.constraint(equalToConstant: 600),
            self.treeImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 430),
            self.treeImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.araraImageView.widthAnchor.constraint(equalToConstant: 1000),
            self.araraImageView.heightAnchor.constraint(equalToConstant: 600),
            
            self.spiritImageView.widthAnchor.constraint(equalToConstant: 400),
            self.spiritImageView.heightAnchor.constraint(equalToConstant: 800),
            
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
        let text: String = "Descubra uma vida secreta por tr??s da alma da natureza".localized()
        self.title.backgroundColor = .clear
        self.title.textColor = .white
        self.title.font = UIFont(name: "Poppins-SemiBold", size: 27)
        self.title.typeOn(string: text)
        
        self.spiritSV.translatesAutoresizingMaskIntoConstraints = false
        self.spiritSV.axis = .horizontal
        
        self.spiritView.translatesAutoresizingMaskIntoConstraints = false
        
        self.spiritImageView.translatesAutoresizingMaskIntoConstraints = false
        self.spiritImageView.image = UIImage(named: "EspiritoNormal")
        
        self.treeBirdSV.axis = .vertical
        self.treeBirdSV.translatesAutoresizingMaskIntoConstraints = false
        self.treeView.translatesAutoresizingMaskIntoConstraints = false
        self.treeImageView.translatesAutoresizingMaskIntoConstraints = false
        self.araraImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.treeBirdSV.bringSubviewToFront(self.treeView)
        
        self.treeImageView.image = UIImage(named: "Arvores")
        
        let url = Bundle.main.url(forResource: "araravoando", withExtension: "gif")!
        self.araraImageView.image = UIImage.gifImageWithURL(url)
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 3.0, delay: 3.0, options: .curveEaseIn, animations: {
                
            }, completion: {_ in
                UIView.animate(withDuration: 5.0, delay: 0, options: .curveEaseIn, animations: {
                    self.araraImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -200).isActive = true
                    self.layoutIfNeeded()
                }, completion: nil)
            })
        }
    }
}

