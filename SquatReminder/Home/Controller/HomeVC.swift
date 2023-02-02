//
//  ViewController.swift
//  SquatReminder
//
//  Created by Suzie on 1/30/23.
//



import UIKit
import BarChartKit

class HomeVC: UIViewController {
    let colors = ColorManager()
    let welcomeLabel =  UILabel()
    let nameLabel = UILabel()
    let welcomeView = WelcomeView()
    let todayLabel = UILabel()
    let weekLabel = UILabel()
    let monthLabel = UILabel()
    
    let stackView = UIStackView()
    let todayView = TodayView()
    let weeklyView = WeeklyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Home"
        configureStackView()
        addToStackView()
    }
    
    func configureStackView(){
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 7
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
    }
    
    func addToStackView(){
        stackView.addArrangedSubview(welcomeView)
        stackView.addArrangedSubview(todayView)
        stackView.addArrangedSubview(weeklyView)
        
        if #available(iOS 16.0, *) {
            let monthlyView = MonthView()
            stackView.addArrangedSubview(monthlyView)
        }
    }
    
}

