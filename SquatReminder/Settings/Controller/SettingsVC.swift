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
    let maxSquatView = MaxSquatView()
    let timePickerView = TimePickerView()
    let nameButton = Buttons()
    let welcomeView = WelcomeView()
    let notifcationView = NotificationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        squatButtonView.isUserInteractionEnabled = true
        setupSettingsLabel()
        setupSquatButtonView()
        setupNotificationTitleLabel()
        setupNotificationView()
        setupMaxSquatView()
        setupRemindersLabel()
        setupTimePickerView()
        setupNameButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        squatButtonView.setupSquatButton()
        timePickerView.setupEndTimePicker()
        timePickerView.setupStartTimePicker()
        
        if UserDefaults.standard.string(forKey: "key-name") != nil {
            nameButton.setTitle(UserDefaults.standard.string(forKey: "key-name"), for: .normal)
        } else {
            nameButton.setTitle("ADD NAME", for: .normal)
        }
    
        if UserDefaults.standard.bool(forKey: "outletSwitch"){
            notificationView.notificationSwitch.setOn(true, animated: false)
//            notificationView.scheduleLocal()
        } else {
            notificationView.notificationSwitch.setOn(false, animated: false)
        }
    }
    
    func setupSettingsLabel() {
        view.addSubview(settingsLabel)
        settingsLabel.text = "Settings"
        settingsLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        settingsLabel.translatesAutoresizingMaskIntoConstraints = false
        settingsLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        settingsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        settingsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
    }
    
    func setupSquatButtonView() {
        view.addSubview(squatButtonView)
        
        squatButtonView.translatesAutoresizingMaskIntoConstraints = false
        squatButtonView.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor, constant: 15).isActive = true
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
    
    func setupMaxSquatView() {
        view.addSubview(maxSquatView)
        maxSquatView.translatesAutoresizingMaskIntoConstraints = false
        maxSquatView.topAnchor.constraint(equalTo: notificationView.bottomAnchor, constant: 40).isActive = true
        maxSquatView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        maxSquatView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
    }
    
    func setupRemindersLabel() {
        view.addSubview(remindersLabel)
        remindersLabel.setupLabel(inputText: "WHEN DO YOU WANT TO BE REMINDED")
        
        remindersLabel.translatesAutoresizingMaskIntoConstraints = false
        remindersLabel.topAnchor.constraint(equalTo: maxSquatView.bottomAnchor, constant: 30).isActive = true
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
    
    func setupNameButton() {
        view.addSubview(nameButton)
        nameButton.setTitle("ADD NAME", for: .normal)
        nameButton.addTarget(self, action: #selector(alertName), for: .touchUpInside)
        nameButton.backgroundColor = colors.darkPurple
        
        nameButton.translatesAutoresizingMaskIntoConstraints = false
        nameButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nameButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        nameButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        nameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc func alertName() {
        let alertController = UIAlertController(title: "Hi! What's Your Name?", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            // configure the properties of the text field
            textField.placeholder = "Name"
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in
            print("User clicked Edit button")
        }))
        
        alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: {[self, weak alertController] (_) in
            let textField = alertController?.textFields![0]
            UserDefaults.standard.set(textField?.text ?? "", forKey: "key-name")
            let name = UserDefaults.standard.string(forKey: "key-name") ?? ""
            
            //use the key to grab value data (textField?.text)
            //to access the name: let name = UserDefaults.standard.string(forKey: "pp-name") ?? ""
            self.welcomeView.setupNameLabel()
            self.nameButton.setTitle(name, for: .normal)
        }))
        present(alertController, animated: true, completion: nil)
    }
}
