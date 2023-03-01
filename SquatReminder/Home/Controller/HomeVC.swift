//
//  ViewController.swift
//  SquatReminder
//
//  Created by Suzie on 1/30/23.
//
import UIKit
import UserNotifications
import BarChartKit

class HomeVC: UIViewController, NotificationViewDelegate {
    func didTapBanner() {
        print("this was triggered ❌")
        let alertController = UIAlertController(title: "Log Squat", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "0"
        }
        
        alertController.addAction(UIAlertAction(title: "No Squats", style: .default, handler: { (_) in
            print("User clicked Edit button")
        }))
        
        alertController.addAction(UIAlertAction(title: "Log", style: .default, handler: {[self, weak alertController] (_) in
            let textField = alertController?.textFields![0]
            let value = textField?.text ?? ""
            
            let double = Double(value) ?? 0.0
            print("🙃 this is \(double)")
            
            UserDefaults.standard.set(double, forKey: "logSquatAlert")
            let previousCount =  UserDefaults.standard.integer(forKey: "logSquats")
            let tempCount = UserDefaults.standard.integer(forKey: "logSquatAlert")
            let updatedCount = previousCount + tempCount
            UserDefaults.standard.set(updatedCount, forKey: "logSquats")
            todayView.currentSquatButton.setTitle(String(updatedCount), for: .normal)
        }))
        present(alertController, animated: true, completion: nil)
    }
    
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
        notificationView.homeDelegate = self
        configureScrollView()
        configureStackView()
        addToStackView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        welcomeView.setupNameLabel()
        todayView.setupDailyButton()
        
        if UserDefaults.standard.bool(forKey: "outletSwitch") {
            notificationView.onOffSwitch.setOn(true, animated: false)
            notificationView.scheduleLocal()
        } else {
            notificationView.onOffSwitch.setOn(false, animated: false)
        }
        
        let squatCount = UserDefaults.standard.integer(forKey: "logSquats")
        todayView.currentSquatButton.setTitle(String(squatCount), for: .normal)
        
//        let squatCountAlert = UserDefaults.standard.integer(forKey: "logSquatsAlert")
//        todayView.currentSquatButton.setTitle(String(squatCountAlert), for: .normal)
        
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

