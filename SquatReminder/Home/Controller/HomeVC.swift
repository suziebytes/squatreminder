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
        todayView.getCount()
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
            // Fetch result of today's squatEntity.count
            let request: NSFetchRequest<SquatEntity> = SquatEntity.fetchRequest()
            let today = currentDate.currentDate
            // set the filter - filter should check for today's date and the current count for today
            let predicate = NSPredicate(format: "date == %@", today)
            //apply fetch request with filter
            request.predicate = predicate
            // create squatList with empty array & fetch the result
            var squatEntityList: [SquatEntity] = []
            //fetch request results and store into squatEntityList
            do {
                //fetches based on predicates / filters
                squatEntityList = try appDelegate.persistentContainer.viewContext.fetch(request)
                print("lets see the list 🌈", squatEntityList)
            } catch {
                print("Error fetching SquatEntity: \(error)")
            }
            //if there is a value, update value - if there's no value, then create the value ; both will store
            //check for the number of elements of count (not to be confused w/ number of squats logged in count
            if squatEntityList.count > 0 {
                //the first element is the first element of the Squat Entity array, which contains two properties (count and  date)
                guard let previousSquatEntity = squatEntityList.first else {
                    return
                }
                let previousCount = previousSquatEntity.count
//                var date = previousSquatEntity.date
                let updateCount = previousCount + tempCount
                //override the entity we received from our filtered request with the previous count with new count
                previousSquatEntity.count = updateCount
                //save updatedCount to Squat Entity
                appDelegate.saveContext()
            } else { //if no entry for today's date, save today's date and the updated count
                //create new instance of SquatEntity
                let newEntity = SquatEntity(context: appDelegate.persistentContainer.viewContext)
                //assign the new values
                newEntity.date = today
                newEntity.count = tempCount
                appDelegate.saveContext()
            }
            todayView.getCount()
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
