//
//  NotificationView.swift
//  SquatReminder
//
//  Created by Suzie on 2/4/23.
//

import UIKit
import UserNotifications

//1.  Create a protocol + a empty function
//      >> conform to 'AnyObject' >> protocol NotificationViewDelegate: AnyObject
//2.  Create a delegate variable (homeDelegate : NotificationViewDelegate)
//      >> homeDelegate has acccess to the function in the protocol
//      >> Define 'weak' var for var homeDelegate because it creates a 'loop', which leads to a memory leak; commonly           known as retain cycle
//      >> weak var needs to be an optional >> NotificationViewDelegate?
//3. 'Conform' the delegate to other VCs that want to have access to the protocol function // i.e. HomeVC wants access to didTapBanner() so we add HomeVC: NotificationViewDelegate
//4. Xcode will automatically have the 'stubs'
//5.  Access delegate (homeDelegate) from the NotificaitonView inside the HomeVC (VDL)
//6.  Assign it to self (        notificationView.homeDelegate = self       )
//7. Define 'weak' var for var homeDelegate because it creates a 'loop', which leads to a memory leak; commonly known as retain cycle

protocol NotificationViewDelegate: AnyObject {
    func didTapBanner()
}

class NotificationView: UIView, UNUserNotificationCenterDelegate, UITextFieldDelegate {
    weak var homeDelegate: NotificationViewDelegate?
    
    let colors = ColorManager()
    let onOffSwitch = UISwitch()
    let notificationOptionLabel = UILabel()
    let maxSquatLabel = UILabel()
    let timePickerView = TimePickerView()
    let todayView = TodayView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNotifcationOptionLabel()
        setupSwitch()
        checkForPermissions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacterSet = CharacterSet(charactersIn: "0123456789")
        let replacementStringCharacterSet = CharacterSet(charactersIn: string)
        return allowedCharacterSet.isSuperset(of: replacementStringCharacterSet)
    }
    
    func setupNotifcationOptionLabel() {
        addSubview(notificationOptionLabel)
        notificationOptionLabel.text = "Notifications"
        notificationOptionLabel.textColor = colors.darkGray
        notificationOptionLabel.font = UIFont(name:"HelveticaNeue", size: 15.0)
        
        notificationOptionLabel.translatesAutoresizingMaskIntoConstraints = false
        notificationOptionLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        notificationOptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func setupSwitch() {
        addSubview(onOffSwitch)
        onOffSwitch.backgroundColor = colors.lightGray
        onOffSwitch.tintColor = colors.lightGray
        onOffSwitch.onTintColor = colors.darkPurple
        onOffSwitch.layer.cornerRadius = 15
        onOffSwitch.layer.borderColor = colors.darkGray.cgColor
        onOffSwitch.layer.borderWidth = 1
        onOffSwitch.addTarget(self, action: #selector(switchDidChange), for: .valueChanged)
        
        if UserDefaults.standard.bool(forKey: "outletSwitch"){
            onOffSwitch.setOn(true, animated: false)
            scheduleLocal()
        } else {
            onOffSwitch.setOn(false, animated: false)
        }
        
        onOffSwitch.translatesAutoresizingMaskIntoConstraints = false
        onOffSwitch.topAnchor.constraint(equalTo: topAnchor).isActive = true
        onOffSwitch.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        onOffSwitch.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    @objc func switchDidChange(_ sender:UISwitch) {
        if sender.isOn == true {
            print("notifications on")
            UserDefaults.standard.set(true, forKey: "outletSwitch")
            //request permission from user to send notificaitons
            
            //request authorization for notifications from user
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .badge, .sound]) {
                granted, error in
                if granted {
                    print("YAY")
                    self.scheduleLocal()
                } else {
                    print("❌ NOOOO")
                }
            }
        } else {
            UserDefaults.standard.set(false, forKey: "outletSwitch")
            print("notifications off")
        }
    }
    
    func scheduleLocal() {
        registerCategories()
        
        //access current notice of user notifications
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "SQUAT TIME"
        content.body = "Drop it like a Squat"
        content.sound = .default
        content.userInfo = ["logsquats": "add to count"]
        content.categoryIdentifier = "squatsReminderCategory"
        
        //        let componentsFromDate = Calendar.current.dateComponents(in: TimeZone.current, from: timePickerView.startTimePicker.date)
        //        print("this is componentsFromDaate \(componentsFromDate)")
        
        //        let trigger = UNCalendarNotificationTrigger(dateMatching: componentsFromDate, repeats: true)
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        //        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        let request = UNNotificationRequest(identifier: "squatsReminder", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        center.add(request)
    }
    
    func checkForPermissions() {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                self.scheduleLocal()
            }
        }
    }
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let noSquats = UNNotificationAction(
            identifier: "squatsReminder.doneAction",
            title: "I didn't Squat",
            options: [])
        let logSquats = UNTextInputNotificationAction(
            identifier: "squatsReminder.howManySquatsInputAction",
            title: "Log Squats",
            options: [],
            textInputButtonTitle: "Submit",
            textInputPlaceholder: "How Many Squats Did You Do?")
        let logSquatsReminderCategory = UNNotificationCategory(
            identifier: "squatsReminderCategory",
            actions: [logSquats, noSquats],
            intentIdentifiers: [],
            options: .customDismissAction)
        UNUserNotificationCenter.current().setNotificationCategories([logSquatsReminderCategory])
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        let application = UIApplication.shared
        
        if(application.applicationState == .active){
         
            homeDelegate?.didTapBanner()
            print("user tapped the notification bar when the app is in foreground")
        }
        
        if(application.applicationState == .inactive)
        {
            homeDelegate?.didTapBanner()

            print("user tapped the notification bar when the app is in background")
        }
        
        switch response.actionIdentifier {
        case "squatsReminder.doneAction":
            print("hello")
        case "squatsReminder.howManySquatsInputAction":
            if let userInput = (response as? UNTextInputNotificationResponse)?.userText {
                print(userInput)
                if CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: userInput)) {
                    guard let tempCount = Int(userInput) else {
                        print("failed because there was no number value")
                        return
                    }
                    //get the previous count (using standard.integer instead of 'set')
                    let previousCount =  UserDefaults.standard.integer(forKey: "logSquats")
                    // add previous count + new count
                    let updatedCount = previousCount + tempCount
                    //update the same key with the updateCount
                    UserDefaults.standard.set(updatedCount, forKey: "logSquats")
                    
                } else {
                    let alertController = UIAlertController(title: "Enter Numbers Only", message: "", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                        print("User clicked OK")
                    }))
                    self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                }
            }
            
        default:
            break
        }
        completionHandler()
    }
}

