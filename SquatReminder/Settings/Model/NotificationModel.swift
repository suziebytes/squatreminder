//
//  NotificationModel.swift
//  SquatReminder
//
//  Created by Suzie on 3/21/23.
//

import UIKit
import UserNotifications

protocol NotificationViewDelegate: AnyObject {
    func didTapBanner()
}

class NotificationModel: NSObject, UNUserNotificationCenterDelegate {
    weak var homeDelegate: NotificationViewDelegate?

    var homeVC: HomeVC?
    let todayView = TodayView()
    var logSquatsModel = LogSquatsModel()
    
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
                UserDefaults.standard.set(true, forKey: "notificationSwitch")
                print("🔥 GRANTED SET TO TRUE")
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
                    guard let tempCount = Double(userInput) else {
                        print("failed because there was no number value")
                        return
                    }
                    logSquatsModel.updateResults(tempCount: tempCount)
                    
                } else {
                    let alertController = UIAlertController(title: "Enter Numbers Only", message: "", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                        print("User clicked OK")
                    }))
                    let window = UIApplication.shared.keyWindow
                    window?.rootViewController?.present(alertController, animated: true, completion: nil)
                }
            }
        default:
            break
        }
        todayView.getCount()
        homeVC?.monthlyView.createCalendar()
        homeVC?.weeklyView.setupBarChart()
        completionHandler()
    }
}
