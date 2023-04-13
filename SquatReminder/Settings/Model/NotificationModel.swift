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
    var hasNotScheduled = true
    
    func checkCurrentTime() {
        //Assign variables to start + end time from date picker - these are type Strings
        guard
            let startTime = UserDefaults.standard.string(forKey: "selectedStartTime"),
            let endTime = UserDefaults.standard.string(forKey: "selectedEndTime")
        else {
            return
        }
        
        let today = Date()
        let startDate = convertStringToDate(time: startTime)
        let endDate = convertStringToDate(time: endTime)
        
        let todayHM = getHourMin(time: today)
        let startHM = getHourMin(time: startDate)
        let endHM = getHourMin(time: endDate)
        let todayHour = todayHM.0
        let todayMinute = todayHM.1
        let startHour = startHM.0
        let startMinute = startHM.1
        let endHour = endHM.0
        let endMinute = endHM.1
        
        let sameHourWithinMinuteRange = todayHour == startHour && todayHour == endHour && todayMinute > startMinute && todayMinute < endMinute
        let withinStartAndEndHour = todayHour > startHour && todayHour < endHour
        let sameStartHour = todayHour == startHour && todayMinute >= startMinute && todayHour < endHour
        let sameEndHour = todayHour == endHour && todayMinute <= endMinute && todayHour > startHour
        
        let withinTimeFrame = sameHourWithinMinuteRange || withinStartAndEndHour || sameStartHour || sameEndHour

        //if within timeframe + has not scheduled -> schedule + toggle hasNotScheduled to false
        if withinTimeFrame && hasNotScheduled {
            scheduleLocal()
            hasNotScheduled = false
            print("🔥 Inside")
        }
        //if outside timeframe - removepending and toggle to true (not scheduled)
        if !withinTimeFrame {
            removePendingNotifications()
            hasNotScheduled = true
            print("💧 Outside")
        }
    }
    
    func convertStringToDate(time: String) -> Date {
        //Convert String date to be Type Date
        dateFormatter.locale = Locale(identifier: "en-US")
        dateFormatter.setLocalizedDateFormatFromTemplate("hh:mm a")
        dateFormatter.dateFormat = "hh:mm a"
        
        guard let time = dateFormatter.date(from: time) else {
            return Date()
        }
        return time
    }
    
    func getHourMin(time: Date) -> (Int, Int) {
        let hour = calendar.component(.hour, from: time)
        let min = calendar.component(.minute, from: time)
        
        //return tuple
        return (hour, min)
    }
    
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
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3600, repeats: true)
        
        //let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger, triggerTimeInterval)
        let request = UNNotificationRequest(identifier: "squatsReminder", content: content, trigger: trigger)
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
                //                print("🔥 GRANTED SET TO TRUE")
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
                    let alertController = UIAlertController(
                        title: "Enter Numbers Only",
                        message: "",
                        preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(
                        title: "Ok",
                        style: .default,
                        handler: { (_) in
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
