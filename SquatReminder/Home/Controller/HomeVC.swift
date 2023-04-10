//
//  ViewController.swift
//  SquatReminder
//
//  Created by Suzie on 1/30/23.
//
import UIKit
import UserNotifications
import BarChartKit
import CoreData
import ConfettiView

class HomeVC: UIViewController, NotificationViewDelegate {
    var currentDate = CurrentDate()
    let colors = ColorManager()
    let welcomeView = WelcomeView()
    let stackView = UIStackView()
    let todayView = TodayView()
    let weeklyView = WeeklyView()
    let scrollView = UIScrollView()
    let monthlyView = MonthView()
    let squatButtonView = SquatButtonView()
    let notificationView = NotificationView()
    var logSquatModel = LogSquatsModel()
    var squatEntityList: [SquatEntity] = []
    var weeklyViewModel = WeeklyViewModel()
    let notificationModel = NotificationModel()
    let confettiView = ConfettiView()
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Home"
        notificationView.homeDelegate = self
        notificationModel.checkForPermissions()
        configureScrollView()
        configureStackView()
        addToStackView()
        notificationView.homeVC = self
        logSquatModel.homeVC = self
        notificationModel.homeDelegate = self
        setupConfetti()
        
        todayView.currentSquatButton.addTarget(self, action: #selector(didTapBanner), for: .touchUpInside)
        
        //execute Timer function every 60 seconds
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.notificationModel.checkCurrentTime()
       })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        welcomeView.setupNameLabel()
        todayView.setupDailyButton()
        weeklyView.setupBarChart()
        todayView.getCount()
        
        if UserDefaults.standard.bool(forKey: "notificationSwitch") {
            notificationModel.checkCurrentTime()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func willEnterForeground() {
        todayView.getCount()
    }
    
    func setupConfetti() {
        view.addSubview(confettiView)
        confettiView.translatesAutoresizingMaskIntoConstraints = false
        confettiView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        confettiView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        confettiView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        confettiView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }
    
    func displayConfetti() {
        let countGoal = UserDefaults.standard.string(forKey: "key-goal") ?? ""
        let currentCount = logSquatModel.currentCount
//        print(currentCount, countGoal, "these are the current count to compare  ⚡️")
        
        if currentCount >= Int(countGoal) ?? 0 {
            confettiView.emit(with: [
                .shape(.circle, colors.darkPurple),
                .shape(.triangle, colors.lightPurple),
                .shape(.square, colors.lightGray)
            ]) {_ in
                // Optional completion handler fires when animation finishes.
                print("hurray hurray")
            }
        }
    }
    
    //MARK: Notification Banner Updates
    @objc func didTapBanner() {
        print("this was triggered ❌")
        let alertController = UIAlertController(
            title: "Log Squat",
            message: "",
            preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "0"
            textField.keyboardType = .numberPad
        }
        
        alertController.addAction(UIAlertAction(
            title: "No Squats",
            style: .default,
            handler: { (_) in
            print(" ❌ User Didn't Squat")
        }))
        
        alertController.addAction(UIAlertAction(
            title: "Log",
            style: .default,
            handler: {[self, weak alertController] (_) in
            let textField = alertController?.textFields![0]
            let value = textField?.text ?? ""
            let tempCount = Double(value) ?? 0 //store the inputted user value
            
            //ensures that everything is performed on the main thread; typically UI actions is performed on main thread
            DispatchQueue.main.async {
                self.logSquatModel.updateResults(tempCount: tempCount)
                self.todayView.getCount()
                self.updateMonthAndWeek()
            }
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    func updateMonthAndWeek() {
        weeklyView.setupBarChart()
        monthlyView.createCalendar()
    }
    
    //MARK: UI Configuration
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
    }
    
    func configureStackView() {
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
    
    func addToStackView() {
        stackView.addArrangedSubview(welcomeView)
        stackView.addArrangedSubview(todayView)
        stackView.addArrangedSubview(weeklyView)
        stackView.addArrangedSubview(monthlyView)
    }
}
