//
//  SettingsVC.swift
//  SquatReminder
//
//  Created by Suzie on 1/31/23.
//

import UIKit
import UserNotifications

class SettingsVC: UIViewController, UNUserNotificationCenterDelegate {
    let colors = ColorManager()
    let settingsLabel = UILabel()
    let squatButtonView = SquatButtonView()
    let notificationTitleLabel = HeaderLabel()
    let remindersLabel = HeaderLabel()
    let notificationView = NotificationView()
    let notificationModel = NotificationModel()
    let maxSquatView = MaxSquatView()
    let timePickerView = TimePickerView()
    let nameButton = Buttons()
    let welcomeView = WelcomeView()
    let nameView = NameView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        squatButtonView.isUserInteractionEnabled = true
        
        setupSettingsLabel()
        setupNameView()
        setupSquatButtonView()
        setupNotificationTitleLabel()
        setupNotificationView()
//        setupMaxSquatView()
        setupRemindersLabel()
        setupTimePickerView()
//        setupWelcomeView()
        nameView.settingsVC = self 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        squatButtonView.setupSquatButton()
        
        if UserDefaults.standard.string(forKey: "key-name") != nil {
            let storedName = UserDefaults.standard.string(forKey: "key-name")
            nameView.nameButton.setTitle(storedName?.uppercased(), for: .normal)
//            welcomeView.isHidden = false
//            nameView.isHidden = true
    
        } else {
            nameView.nameButton.setTitle("ADD NAME", for: .normal)
//            welcomeView.isHidden = true
        }
    
        if UserDefaults.standard.bool(forKey: "notificationSwitch"){
            notificationView.notificationSwitch.setOn(true, animated: false)
            notificationModel.checkCurrentTime()
        } else {
            notificationView.notificationSwitch.setOn(false, animated: false)
        }
    }
 
    func setupSettingsLabel() {
        view.addSubview(settingsLabel)
        settingsLabel.text = "Settings"
        settingsLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        settingsLabel.translatesAutoresizingMaskIntoConstraints = false
        settingsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        settingsLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        settingsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
    }
    
    func setupNameView() {
        view.addSubview(nameView)
        nameView.translatesAutoresizingMaskIntoConstraints = false
        nameView.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor).isActive = true
        nameView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        nameView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
//    func setupWelcomeView() {
//        view.addSubview(welcomeView)
//        welcomeView.translatesAutoresizingMaskIntoConstraints = false
//        welcomeView.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor).isActive = true
//        welcomeView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
//        welcomeView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//    }
    
    func setupSquatButtonView() {
        view.addSubview(squatButtonView)
        squatButtonView.translatesAutoresizingMaskIntoConstraints = false
        squatButtonView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 15).isActive = true
        squatButtonView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        squatButtonView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func setupNotificationTitleLabel() {
        view.addSubview(notificationTitleLabel)
        notificationTitleLabel.setupLabel(inputText: "NOTIFICATION SETTINGS")
        notificationTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        notificationTitleLabel.topAnchor.constraint(equalTo: squatButtonView.bottomAnchor, constant: 30).isActive = true
        notificationTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
    }
    
    func setupNotificationView() {
        view.addSubview(notificationView)
        notificationView.translatesAutoresizingMaskIntoConstraints = false
        notificationView.topAnchor.constraint(equalTo: notificationTitleLabel.bottomAnchor, constant: 30).isActive = true
        notificationView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        notificationView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
    }
//
//    func setupMaxSquatView() {
//        view.addSubview(maxSquatView)
//        maxSquatView.translatesAutoresizingMaskIntoConstraints = false
//        maxSquatView.topAnchor.constraint(equalTo: notificationView.bottomAnchor, constant: 40).isActive = true
//        maxSquatView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
//        maxSquatView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
//    }
    
    func setupRemindersLabel() {
        view.addSubview(remindersLabel)
        remindersLabel.setupLabel(inputText: "WHEN DO YOU WANT TO BE REMINDED")
        remindersLabel.translatesAutoresizingMaskIntoConstraints = false
        remindersLabel.topAnchor.constraint(equalTo: notificationView.bottomAnchor, constant: 30).isActive = true
        remindersLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        remindersLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func setupTimePickerView() {
        view.addSubview(timePickerView)
        timePickerView.translatesAutoresizingMaskIntoConstraints = false
        timePickerView.topAnchor.constraint(equalTo: remindersLabel.bottomAnchor, constant: 10).isActive = true
        timePickerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        timePickerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
    }
}
