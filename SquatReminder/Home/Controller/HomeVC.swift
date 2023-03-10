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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Home"
        notificationView.homeDelegate = self
        configureScrollView()
        configureStackView()
        addToStackView()
        logSquatModel.logDate()
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc func willEnterForeground() {
        let squatCount = UserDefaults.standard.integer(forKey: "logSquats")
        todayView.currentSquatButton.setTitle(String(squatCount), for: .normal)
        
    }
    
    //MARK: Notification Banner Updates
    func didTapBanner() {
        print("this was triggered ❌")
        let alertController = UIAlertController(title: "Log Squat", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "0"
        }
        
        alertController.addAction(UIAlertAction(title: "No Squats", style: .default, handler: { (_) in
            print(" ❌ User Didn't Squat")
        }))
        
        alertController.addAction(UIAlertAction(title: "Log", style: .default, handler: {[self, weak alertController] (_) in
            let textField = alertController?.textFields![0]
            let value = textField?.text ?? ""
            
            //store the inputted user value
            let tempCount = Int64(value) ?? 0
            
            // initialize SquatEntity Class
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let squatEntity = SquatEntity(context: appDelegate.persistentContainer.viewContext)
            // Fetch result of today's squatEntity.count
            var request: NSFetchRequest<SquatEntity> = SquatEntity.fetchRequest()
            let today = currentDate.currentDate
            // set the filter - filter should check for today's date and the current count for today
            let predicate = NSPredicate(format: "count == %@ AND date == %@", today)
            //apply fetch request with filter
            request.predicate = predicate
            //fetch request results and store into squatEntityList
            do {
                let squatEntityList = try appDelegate.persistentContainer.viewContext.fetch(request)
                if let squatEntity = squatEntityList.first {
                    //update squat count
                    squatEntity.count += tempCount
                    // Save the new count into squatEntity.count
                    try appDelegate.persistentContainer.viewContext.save()
                }
            } catch {
                print("Error fetching SquatEntity: \(error)")
            }
            //figure out how to handle saving count for respective date
        }))
        present(alertController, animated: true, completion: nil)
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
