//
//  NotificationView.swift
//  SquatReminder
//
//  Created by Suzie on 2/4/23.
//

import UIKit
import UserNotifications
import CoreData

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

//protocol NotificationViewDelegate: AnyObject {
//    func didTapBanner()
//}

class NotificationView: UIView, UNUserNotificationCenterDelegate, UITextFieldDelegate {
    weak var homeDelegate: NotificationViewDelegate?
    
    let colors = ColorManager()
    let notificationSwitch = NotificationSwitch()
    let notificationOptionLabel = UILabel()
    let maxSquatLabel = UILabel()
    let timePickerView = TimePickerView()
//    let todayView = TodayView()
//    var logSquatsModel = LogSquatsModel()
    var homeVC: HomeVC?
    let notificationModel = NotificationModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNotifcationOptionLabel()
        setupSwitch()
        notificationModel.checkForPermissions()
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
        addSubview(notificationSwitch)
        notificationSwitch.setupSwitch()
        notificationSwitch.addTarget(self, action: #selector(switchDidChange), for: .valueChanged)
        
        if UserDefaults.standard.bool(forKey: "notificationSwitch"){
            notificationSwitch.setOn(true, animated: false)
            notificationModel.scheduleLocal()
        } else {
            notificationSwitch.setOn(false, animated: false)
        }
        
        notificationSwitch.translatesAutoresizingMaskIntoConstraints = false
        notificationSwitch.topAnchor.constraint(equalTo: topAnchor).isActive = true
        notificationSwitch.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        notificationSwitch.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    @objc func switchDidChange(_ sender:UISwitch) {
        if sender.isOn == true {
            print("notifications on")
            UserDefaults.standard.set(true, forKey: "notificationSwitch")
            //request permission from user to send notificaitons
            
            //request authorization for notifications from user
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .badge, .sound]) {
                granted, error in
                if granted {
                    print("YAY")
                    self.notificationModel.scheduleLocal()
                } else {
                    print("❌ NOOOO")
                }
            }
        } else {
            UserDefaults.standard.set(false, forKey: "notificationSwitch")
            print("notifications off")
        }
    }
}

