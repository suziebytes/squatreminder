//
//  DateModel.swift
//  SquatReminder
//
//  Created by Suzie on 3/1/23.
//

import UIKit

struct CurrentDate {
    let dayOfWeek = "Sun"
    
    func currentDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en-US")
        let currentDate: Void = dateFormatter.setLocalizedDateFormatFromTemplate("EEE MMM d yyyy")
        print("☀️ this is the today's date", dateFormatter.string(from: Date())) // "Tue, Mar 20, 2018"
        let dayOfWeek: Void = dateFormatter.setLocalizedDateFormatFromTemplate("EEE")
        print("🌈 this is the day of the week", dateFormatter.string(from: Date())) // "Tue, Mar 20, 2018"
    }
}
