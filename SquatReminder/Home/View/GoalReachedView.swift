//
//  GoalReachedView.swift
//  SquatReminder
//
//  Created by Suzie on 3/22/23.
//
import UIKit

class GoalReachedView: CardView {
    let goalReachedLabel = SpacedLabel()
    let colors = ColorManager()
    let button = UIButton()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupView()
        setupGoalReachedLabel()
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .white
    }
    
    func setupGoalReachedLabel() {
        addSubview(goalReachedLabel)
        goalReachedLabel.setupLabel(inputText: "GOAL REACHED")
        goalReachedLabel.textColor = colors.darkGray
        goalReachedLabel.translatesAutoresizingMaskIntoConstraints = false
        goalReachedLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        goalReachedLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func setupButton() {
        addSubview(button)
        button.setTitle("YAY", for: .normal)
        button.addTarget(self, action: #selector(closePopUp), for: .touchUpInside)
        button.backgroundColor = colors.darkPurple
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 75).isActive = true
        button.topAnchor.constraint(equalTo: goalReachedLabel.bottomAnchor, constant: 15).isActive = true
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    @objc func closePopUp() {
        print("i was closed")
    }
    
}
