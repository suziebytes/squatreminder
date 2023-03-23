//
//  DateModel.swift
//  SquatReminder
//
//  Created by Suzie on 3/1/23.
//

import UIKit

struct CurrentDate {
    let dateFormatter = DateFormatter()
    let date = Date()
    var dayOfWeek = ""
    var currentTime = ""
    
    func getCurrentDate() -> String {
        dateFormatter.locale = Locale(identifier: "en-US")
        dateFormatter.setLocalizedDateFormatFromTemplate("EEE MMM d yyyy")
        return dateFormatter.string(from: Date())
    }
    
    mutating func getDayOfWeek() -> String {
        dateFormatter.locale = Locale(identifier: "en-US")
        dateFormatter.setLocalizedDateFormatFromTemplate("EEE")
        dayOfWeek = dateFormatter.string(from: Date()) // "Tue"
        return dayOfWeek
    }
    
    mutating func getTime() -> String {
        dateFormatter.dateFormat = "HH:mm:ss"
        currentTime = dateFormatter.string(from: Date())
        return currentTime
    }
}
