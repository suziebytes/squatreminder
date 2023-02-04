//
//  NotificationView.swift
//  SquatReminder
//
//  Created by Suzie on 2/4/23.
//

import UIKit

class NotificationView: UIView {
    let colors = ColorManager()
    let onOffSwitch = UISwitch()
    let notificationOptionLabel = UILabel()
    let maxSquatLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
      
        setupNotifcationOptionLabel()
        setupSwitch()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupNotifcationOptionLabel() {
        addSubview(notificationOptionLabel)
        notificationOptionLabel.text = "Notifications"
        notificationOptionLabel.textColor = colors.darkGray
        notificationOptionLabel.font = UIFont(name:"HelveticaNeue-Medium", size: 15.0)

        notificationOptionLabel.translatesAutoresizingMaskIntoConstraints = false
        notificationOptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        notificationOptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func setupSwitch() {
        addSubview(onOffSwitch)
        onOffSwitch.backgroundColor = colors.darkPurple
        onOffSwitch.layer.cornerRadius = 15
        
        onOffSwitch.translatesAutoresizingMaskIntoConstraints = false
        onOffSwitch.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        onOffSwitch.leftAnchor.constraint(equalTo: notificationOption.rightAnchor).isActive = true
        onOffSwitch.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        onOffSwitch.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
}
