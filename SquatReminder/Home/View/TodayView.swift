//
//  TodayView.swift
//  SquatReminder
//
//  Created by Suzie on 1/31/23.
//

import UIKit

class TodayView: UIView {
    let colors = ColorManager()
    let todayLabel = UILabel()
    let currentSquatButton = Buttons()
    let currentSquatLabel = DescriptionLabel()
    let dailySquatButton = Buttons()
    let dailySquatLabel = DescriptionLabel()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTodayLabel()
        setupCurrentLabel()
        setupCurrentSquatButton()
        setupDailyButton()
        setupDailyLabel()
        setupCurrentLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTodayLabel() {
        addSubview(todayLabel)
        todayLabel.text = "Today"
        todayLabel.textColor = .black
        todayLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        
        todayLabel.translatesAutoresizingMaskIntoConstraints = false
        todayLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        todayLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
    
    func setupCurrentSquatButton(){
        addSubview(currentSquatButton)
        currentSquatButton.backgroundColor = colors.darkPurple
        currentSquatButton.tintColor = .white
        currentSquatButton.setTitle("5", for: .normal)
        currentSquatButton.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 100)
        
        currentSquatButton.translatesAutoresizingMaskIntoConstraints = false
        currentSquatButton.topAnchor.constraint(equalTo: todayLabel.bottomAnchor, constant: 5).isActive = true
        currentSquatButton.heightAnchor.constraint(equalToConstant: 140).isActive = true
        currentSquatButton.widthAnchor.constraint(equalToConstant: 145).isActive = true
        currentSquatButton.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        currentSquatButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func setupCurrentLabel() {
        currentSquatButton.addSubview(currentSquatLabel)
        currentSquatLabel.setupLabel(labelTitle: "SQUATTED")
        currentSquatLabel.translatesAutoresizingMaskIntoConstraints = false
        currentSquatLabel.bottomAnchor.constraint(equalTo: currentSquatButton.bottomAnchor, constant: -5).isActive = true
        currentSquatLabel.centerXAnchor.constraint(equalTo: currentSquatButton.centerXAnchor).isActive = true
    }
    
    func setupDailyButton() {
        addSubview(dailySquatButton)
        dailySquatButton.backgroundColor = colors.darkPurple
        dailySquatButton.tintColor = .white
        dailySquatButton.setTitle("100", for: .normal)
        dailySquatButton.titleLabel?.adjustsFontSizeToFitWidth = true
        dailySquatButton.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 60)
        
        dailySquatButton.translatesAutoresizingMaskIntoConstraints = false
        dailySquatButton.heightAnchor.constraint(equalToConstant: 130).isActive = true
        dailySquatButton.widthAnchor.constraint(equalToConstant: 130).isActive = true
        dailySquatButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        dailySquatButton.topAnchor.constraint(equalTo: todayLabel.bottomAnchor, constant: 10).isActive = true
    }
    
    func setupDailyLabel() {
        dailySquatButton.addSubview(dailySquatLabel)
        dailySquatLabel.setupLabel(labelTitle: "DAILY GOAL")
        dailySquatLabel.translatesAutoresizingMaskIntoConstraints = false
        dailySquatLabel.bottomAnchor.constraint(equalTo: dailySquatButton.bottomAnchor, constant: -5).isActive = true
        dailySquatLabel.centerXAnchor.constraint(equalTo: dailySquatButton.centerXAnchor).isActive = true
    }
}
