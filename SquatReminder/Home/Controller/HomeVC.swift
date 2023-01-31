//
//  ViewController.swift
//  SquatReminder
//
//  Created by Suzie on 1/30/23.
//

import UIKit

class HomeVC: UIViewController {
    let colors = ColorManager()
    let welcomeLabel =  UILabel()
    let nameLabel = UILabel()
    let todayLabel = UILabel()
    let weekLabel = UILabel()
    let monthLabel = UILabel()
    
    let stackView = UIStackView()
    let todayView = TodayView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupWelcomeLabel()
        setupNameLabel()
        configureStackView()
        addToStackView()
    }
    
    func setupWelcomeLabel() {
        view.addSubview(welcomeLabel)
        welcomeLabel.textColor = colors.darkPurple
        welcomeLabel.text = "WELCOME BACK"
        welcomeLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 25.0)
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 75).isActive = true
        welcomeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
    }
    
    func setupNameLabel() {
        view.addSubview(nameLabel)
        nameLabel.text = "KIMBERLY"
        nameLabel.textColor = colors.lightPurple
        nameLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 45.0)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 5).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
    }
    
    func configureStackView(){
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
    }
    
    func addToStackView(){
        stackView.addArrangedSubview(todayView)

    }
//    func setupTodayLabel() {
//        view.addSubview(todayLabel)
//        todayLabel.text = "Today"
//        todayLabel.textColor = .black
//        todayLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 35.0)
//
//    }
//
//    func setupWeekLabel() {
//        view.addSubview(weekLabel)
//        weekLabel.text = "WEEKLY"
//        weekLabel.textColor = .black
//        weekLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 25.0)
//    }
//
//    func setupMonthLabel() {
//        view.addSubview(monthLabel)
//        monthLabel.text = "MONTHLY"
//        monthLabel.textColor = .black
//        monthLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 25.0)
//
//    }
}
    
