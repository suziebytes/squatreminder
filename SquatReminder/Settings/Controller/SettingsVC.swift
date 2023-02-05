//
//  SettingsVC.swift
//  SquatReminder
//
//  Created by Suzie on 1/31/23.
//

import UIKit

class SettingsVC: UIViewController {
    let colors = ColorManager()
    let settingsLabel = UILabel()
    let squatButtonView = SquatButtonView()
    let notificationTitleLabel = UILabel()
    let notificationView = NotificationView()
    let maxSquatView = MaxSquatView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSettingsLabel()
        setupSquatButtonView()
        setupNotificationTitleLabel()
        setupNotificationView()
        setupMaxSquatView()
    }
    
    func setupSettingsLabel() {
        view.addSubview(settingsLabel)
        settingsLabel.text = "Settings"
        settingsLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        
        settingsLabel.translatesAutoresizingMaskIntoConstraints = false
        settingsLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        settingsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        settingsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
    }
    
    func setupSquatButtonView() {
        view.addSubview(squatButtonView)
        
        squatButtonView.translatesAutoresizingMaskIntoConstraints = false
        squatButtonView.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor, constant: 25).isActive = true
        squatButtonView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        squatButtonView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func setupNotificationTitleLabel() {
        view.addSubview(notificationTitleLabel)
        notificationTitleLabel.attributedText = NSAttributedString(string: "NOTIFICATION SETTINGS", attributes: [.kern: 2.00])
        notificationTitleLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 14.0)
        notificationTitleLabel.textColor = colors.darkGray
        
        notificationTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        notificationTitleLabel.topAnchor.constraint(equalTo: squatButtonView.bottomAnchor, constant: 20).isActive = true
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
}
