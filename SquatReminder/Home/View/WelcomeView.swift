//
//  WelcomeView.swift
//  SquatReminder
//
//  Created by Suzie on 1/31/23.
//

import UIKit
 
class WelcomeView: UIView {
    let welcomeLabel =  UILabel()
    let nameLabel = UILabel()
    let colors = ColorManager()
    let name: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupWelcomeLabel()
        setupNameLabel()
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func setupWelcomeLabel() {
        addSubview(welcomeLabel)
        welcomeLabel.textColor = colors.darkPurple
        welcomeLabel.text = "WELCOME BACK"
        welcomeLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        welcomeLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    }
    
    func setupNameLabel() {
        addSubview(nameLabel)
        let name = UserDefaults.standard.string(forKey: "key-name") ?? ""
        nameLabel.text = name
        nameLabel.textColor = colors.lightPurple
        nameLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 40.0)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 2).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
