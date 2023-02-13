//
//  NotificationView.swift
//  SquatReminder
//
//  Created by Suzie on 2/4/23.
//

import UIKit
import UserNotifications

class NotificationView: UIView {
    let colors = ColorManager()
    let onOffSwitch = UISwitch()
    let notificationOptionLabel = UILabel()
    let maxSquatLabel = UILabel()
    let timePickerView = TimePickerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNotifcationOptionLabel()
        setupSwitch()
        checkForPermissions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        //access current notice of user notifications
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "SQUAT TIME"
        content.body = "Drop it like a Squat"
        content.sound = .default
        content.categoryIdentifier = "alarm"
        
//        let componentsFromDate = Calendar.current.dateComponents(in: TimeZone.current, from: timePickerView.startTimePicker.date)
//        print("this is componentsFromDaate \(componentsFromDate)")
//
        
        var dateComponents = DateComponents()
        dateComponents.hour = 7
        dateComponents.minute = 30
//        let trigger = UNCalendarNotificationTrigger(dateMatching: componentsFromDate, repeats: true)

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
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
}
