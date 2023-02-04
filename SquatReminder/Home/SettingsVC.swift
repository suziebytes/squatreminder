//
//  SettingsVC.swift
//  SquatReminder
//
//  Created by Suzie on 1/31/23.
//

import UIKit

class SettingsVC: UIViewController {
    let colors = ColorManager()
    let settingsLabel = UILabel()
    let squatButton = Buttons()
    let squatGoalLabel = DescriptionLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSettingsLabel()
        setupSquatButton()
        setupSquatGoalLabel()
    }
    
    func setupSettingsLabel() {
        view.addSubview(settingsLabel)
        settingsLabel.text = "Settings"
        settingsLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        
        settingsLabel.translatesAutoresizingMaskIntoConstraints = false
        settingsLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        settingsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        settingsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
    }
    
    func setupSquatButton() {
        view.addSubview(squatButton)
        squatButton.backgroundColor = colors.darkPurple
        squatButton.setTitle("100", for: .normal)
        squatButton.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 100)

        squatButton.translatesAutoresizingMaskIntoConstraints = false
        squatButton.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor).isActive = true
        squatButton.heightAnchor.constraint(equalToConstant: 150).isActive = true
        squatButton.widthAnchor.constraint(equalToConstant: 220).isActive = true
        squatButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupSquatGoalLabel() {
        squatButton.addSubview(squatGoalLabel)
        squatGoalLabel.setupLabel(labelTitle: "MY SQUAT GOAL")
        
        squatGoalLabel.translatesAutoresizingMaskIntoConstraints = false
        squatGoalLabel.topAnchor.constraint(equalTo: squatButton.topAnchor, constant: 5).isActive = true
        squatGoalLabel.centerXAnchor.constraint(equalTo: squatButton.centerXAnchor).isActive = true
    }
    
}
