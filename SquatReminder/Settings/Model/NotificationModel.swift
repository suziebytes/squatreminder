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
    func updateMonthAndWeek()
}

class NotificationModel: NSObject, UNUserNotificationCenterDelegate {
    weak var homeDelegate: NotificationViewDelegate?
    let calednar = Calendar.current
    let dateFormatter = DateFormatter()
    let center = UNUserNotificationCenter.current()
    let content = UNMutableNotificationContent()
    let todayView = TodayView()
    var logSquatModel = LogSquatsModel()
    let calendar = Calendar.current

    func checkCurrentTime() {
        //let trigger = UNCalendarNotificationTrigger(dateMatching: componentsFromDate, repeats: true)
        //Assign variables to start + end time from date picker - these are type Strings
        guard let startTime = UserDefaults.standard.string(forKey: "selectedStartTime"),
              let endTime = UserDefaults.standard.string(forKey: "selectedEndTime") else {
            return
        }
        
        //Convert String date to be Type Date
        dateFormatter.locale = Locale(identifier: "en-US")
        dateFormatter.setLocalizedDateFormatFromTemplate("hh:ss a")
        dateFormatter.dateFormat = "hh:ss a"
        
        let today = Date()
        guard let start = dateFormatter.date(from: startTime),
              let end = dateFormatter.date(from: endTime) else {
            return
        }
        print("👛👛👛👛👛this is today", today)
        print(" 🌈 this is start", start) //type Date
        print(" 🌈 this is end", end)
        
        if today >= start && today <= end {
            scheduleLocal()
        }
        removePendingNotifications()
    }
    
//    func convertStartToDate() {
//        //let trigger = UNCalendarNotificationTrigger(dateMatching: componentsFromDate, repeats: true)
//        //Assign variables to start + end time from date picker - these are type Strings
//        guard let startTime = UserDefaults.standard.string(forKey: "selectedStartTime") else {
//            return
//        }
//
//        //Convert String date to be Type Date
//        dateFormatter.locale = Locale(identifier: "en-US")
//        dateFormatter.setLocalizedDateFormatFromTemplate("hh:ss a")
//        dateFormatter.dateFormat = "hh:ss a"
//
//        guard let start = dateFormatter.date(from: startTime) else {
//            return
//        }
//
//        let hour = calendar.component(.hour, from: start)
//        let minutes = calendar.component(.minute, from: start)
//        let seconds = calendar.component(.second, from: start)
//        let time = hour:minutes:seconds
//    }
    
    func scheduleLocal() {
        registerCategories()
        //access current notice of user notifications
        center.removeAllPendingNotificationRequests()
        content.title = "SQUAT TIME"
        content.body = "🔥🔥🔥\n Drop it like a Squat!"
        content.sound = .default
        content.userInfo = ["logsquats": "add to count"]
        content.categoryIdentifier = "squatsReminderCategory"
        
        triggerNotifications()
    }
    
    func triggerNotifications() {
        //triggers notificaitons every x time
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)

        //let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger, triggerTimeInterval)
        let request = UNNotificationRequest(identifier: "squatsReminder", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        center.add(request)
    }
    
    func removePendingNotifications() {
        center.removeAllPendingNotificationRequests()
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
                    logSquatModel.updateResults(tempCount: tempCount)
                    
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
        homeDelegate?.updateMonthAndWeek()
        completionHandler()
    }
}
