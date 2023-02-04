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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSettingsLabel()
        setupSquatButton()
    }
    
    func setupSettingsLabel() {
        view.addSubview(settingsLabel)
        settingsLabel.text = "Settings"
        
        settingsLabel.translatesAutoresizingMaskIntoConstraints = false
        settingsLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        settingsLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        settingsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
    }
    
    func setupSquatButton() {
        view.addSubview(squatButton)
        squatButton.backgroundColor = colors.darkPurple
        squatButton.setTitle("100", for: .normal)

        squatButton.translatesAutoresizingMaskIntoConstraints = false
        squatButton.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor).isActive = true
        squatButton.heightAnchor.constraint(equalToConstant: 150).isActive = true
        squatButton.widthAnchor.constraint(equalToConstant: 220).isActive = true
        squatButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
}
