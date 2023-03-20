//
//  notificationsSwitch.swift
//  SquatReminder
//
//  Created by Suzie on 3/20/23.
//

import UIKit

class NotificationSwitch: UISwitch {
    let colors = ColorManager()

    func setupSwitch() {
        backgroundColor = colors.lightGray
        tintColor = colors.lightGray
        onTintColor = colors.darkPurple
        layer.cornerRadius = 15
        layer.borderColor = colors.darkGray.cgColor
        layer.borderWidth = 1
    }
}
