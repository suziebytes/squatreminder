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
    let currentSquatLabel = UILabel()
    let dailySquatButton = Buttons()
    let dailySquatLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTodayLabel()
        setupCurrentLabel()
        setupCurrentSquatButton()
        setupDailyButton()
        setupCurrentLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTodayLabel() {
        addSubview(todayLabel)
        todayLabel.text = "Today"
        todayLabel.textColor = .black
        todayLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 35.0)
        
        todayLabel.translatesAutoresizingMaskIntoConstraints = false
        todayLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        todayLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
    
    func setupCurrentSquatButton(){
        addSubview(currentSquatButton)
        currentSquatButton.backgroundColor = colors.darkPurple
        currentSquatButton.tintColor = .white
        currentSquatButton.setTitle("5", for: .normal)
        currentSquatButton.titleLabel?.adjustsFontSizeToFitWidth = true
        currentSquatButton.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 125)
        
        currentSquatButton.translatesAutoresizingMaskIntoConstraints = false
        currentSquatButton.topAnchor.constraint(equalTo: todayLabel.bottomAnchor, constant: 10).isActive = true
        currentSquatButton.heightAnchor.constraint(equalTo: heightAnchor, constant: 150).isActive = true
        currentSquatButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
        currentSquatButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
    }
    
    func setupCurrentLabel() {
        currentSquatButton.addSubview(currentSquatLabel)
        currentSquatLabel.textColor = .white
        currentSquatLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0) ?? nil
        currentSquatLabel.text = "SQUATTED"
        
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
        dailySquatButton.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 100)
        
        dailySquatButton.translatesAutoresizingMaskIntoConstraints = false
        dailySquatButton.heightAnchor.constraint(equalToConstant: 130).isActive = true
        dailySquatButton.widthAnchor.constraint(equalToConstant: 130).isActive = true
        dailySquatButton.leftAnchor.constraint(equalTo: currentSquatButton.rightAnchor, constant: 10).isActive = true
        dailySquatButton.topAnchor.constraint(equalTo: todayLabel.bottomAnchor, constant: 10).isActive = true
    }
    
    func setupDailyLabel() {
        dailySquatButton.addSubview(dailySquatLabel)
        dailySquatLabel.textColor = .white
        dailySquatLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
        dailySquatLabel.text = "DAILY GOAL"
        
        dailySquatLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
  
}
