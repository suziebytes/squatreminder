//
//  SquatButton.swift
//  SquatReminder
//
//  Created by Suzie on 2/4/23.
//

import UIKit

class SquatButtonView: UIView {
    let colors = ColorManager()
    let squatButton = Buttons()
    let squatGoalLabel = DescriptionLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSquatButton()
        setupSquatGoalLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSquatButton() {
        addSubview(squatButton)
        squatButton.backgroundColor = colors.darkPurple
        squatButton.setTitle("100", for: .normal)
        squatButton.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 100)
        squatButton.addTarget(self, action: #selector(updateSquatGoal), for: .touchUpInside)

        squatButton.translatesAutoresizingMaskIntoConstraints = false
        squatButton.heightAnchor.constraint(equalToConstant: 150).isActive = true
        squatButton.widthAnchor.constraint(equalToConstant: 220).isActive = true
        squatButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    @objc func updateSquatGoal() {
        print("this was tapped")
        squatButton.setTitle("50", for: .normal)
    }
    
    func setupSquatGoalLabel() {
        squatButton.addSubview(squatGoalLabel)
        squatGoalLabel.setupLabel(labelTitle: "MY SQUAT GOAL")
        
        squatGoalLabel.translatesAutoresizingMaskIntoConstraints = false
        squatGoalLabel.bottomAnchor.constraint(equalTo: squatButton.bottomAnchor, constant: -5).isActive = true
        squatGoalLabel.centerXAnchor.constraint(equalTo: squatButton.centerXAnchor).isActive = true
    }
}
