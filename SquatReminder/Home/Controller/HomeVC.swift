//
//  ViewController.swift
//  SquatReminder
//
//  Created by Suzie on 1/30/23.
//
import UIKit
import UserNotifications
import BarChartKit

class HomeVC: UIViewController {
    let colors = ColorManager()
    let welcomeView = WelcomeView()
    let stackView = UIStackView()
    let todayView = TodayView()
    let weeklyView = WeeklyView()
    let scrollView = UIScrollView()
    let monthlyView = MonthView()
    let squatButtonView = SquatButtonView()
    let notificationView = NotificationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Home"
        configureScrollView()
        configureStackView()
        addToStackView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        welcomeView.setupNameLabel()
        todayView.setupDailyButton()
        
        if UserDefaults.standard.bool(forKey: "outletSwitch"){
            notificationView.onOffSwitch.setOn(true, animated: false)
            notificationView.scheduleLocal()
        } else {
            notificationView.onOffSwitch.setOn(false, animated: false)
        }
        
        let squatCount = UserDefaults.standard.integer(forKey: "logSquats")
        todayView.currentSquatButton.setTitle(String(squatCount), for: .normal)
        
        if UserDefaults.standard.bool(forKey: "notificationTapped") {
            print("present alert here nowwwwwwwww 🫠")
        }
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.alwaysBounceVertical = true
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func configureStackView(){
        scrollView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 7
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    func addToStackView(){
        stackView.addArrangedSubview(welcomeView)
        stackView.addArrangedSubview(todayView)
        stackView.addArrangedSubview(weeklyView)
        stackView.addArrangedSubview(monthlyView)
    }
    
}

