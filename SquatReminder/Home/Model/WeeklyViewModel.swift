//
//  WeeklyViewModel.swift
//  SquatReminder
//
//  Created by Suzie on 3/13/23.
//

import UIKit
import CoreData

struct WeeklyViewModel {
    var currentDate = CurrentDate()
    var date = Date() //type Date will give you the day of today
    var calendar = Calendar.current
    var mon = ""
    var tue = ""
    var wed = ""
    var thu = ""
    var fri = ""
    var sat = ""
    var sun = ""
    
    mutating func findMonday(today: String) {
         //type String (because we formatted dateFormatter.string
//        print("🍑🍑🍑🍑🍑🍑", today)
        switch today.prefix(3) { //check to see if its m,t,w,etc
        case "Mon":
            mon = today
            tue = formatDate(date: calendar.date(byAdding: .day, value: +1, to: date) ?? date)
            wed = formatDate(date: calendar.date(byAdding: .day, value: +2, to: date) ?? date)
            thu = formatDate(date: calendar.date(byAdding: .day, value: +3, to: date) ?? date)
            fri = formatDate(date: calendar.date(byAdding: .day, value: +4, to: date) ?? date)
            sat = formatDate(date: calendar.date(byAdding: .day, value: +5, to: date) ?? date)
            sun = formatDate(date: calendar.date(byAdding: .day, value: +6, to: date) ?? date)
        case "Tue":
            //-1 to try to get to monday
            var tueToMon = calendar.date(byAdding: .day, value: -1, to: date) ?? date
            mon = formatDate(date: tueToMon)
            tue = today
            wed = formatDate(date: calendar.date(byAdding: .day, value: +1, to: date) ?? date)
            thu = formatDate(date: calendar.date(byAdding: .day, value: +2, to: date) ?? date)
            fri = formatDate(date: calendar.date(byAdding: .day, value: +3, to: date) ?? date)
            sat = formatDate(date: calendar.date(byAdding: .day, value: +4, to: date) ?? date)
            sun = formatDate(date: calendar.date(byAdding: .day, value: +5, to: date) ?? date)
        case "Wed":
            var wedToMon = calendar.date(byAdding: .day, value: -2, to: date) ?? Date()
            mon = formatDate(date: wedToMon)
            tue = formatDate(date: calendar.date(byAdding: .day, value: -1, to: date) ?? date)
            wed = today
            thu = formatDate(date: calendar.date(byAdding: .day, value: +1, to: date) ?? date)
            fri = formatDate(date: calendar.date(byAdding: .day, value: +2, to: date) ?? date)
            sat = formatDate(date: calendar.date(byAdding: .day, value: +3, to: date) ?? date)
            sun = formatDate(date: calendar.date(byAdding: .day, value: +4, to: date) ?? date)
        case "Thu":
            var thuToMon = calendar.date(byAdding: .day, value: -3, to: date) ?? Date()
            mon = formatDate(date: thuToMon)
            tue = formatDate(date: calendar.date(byAdding: .day, value: -2, to: date) ?? date)
            wed = formatDate(date: calendar.date(byAdding: .day, value: -1, to: date) ?? date)
            thu = today
            fri = formatDate(date: calendar.date(byAdding: .day, value: +1, to: date) ?? date)
            sat = formatDate(date: calendar.date(byAdding: .day, value: +2, to: date) ?? date)
            sun = formatDate(date: calendar.date(byAdding: .day, value: +3, to: date) ?? date)
        case "Fri":
            var friToMon = calendar.date(byAdding: .day, value: -4, to: date) ?? Date()
            mon = formatDate(date: friToMon)
            tue = formatDate(date: calendar.date(byAdding: .day, value: -3, to: date) ?? date)
            wed = formatDate(date: calendar.date(byAdding: .day, value: -2, to: date) ?? date)
            thu = formatDate(date: calendar.date(byAdding: .day, value: -1, to: date) ?? date)
            fri = today
            sat = formatDate(date: calendar.date(byAdding: .day, value: +1, to: date) ?? date)
            sun = formatDate(date: calendar.date(byAdding: .day, value: +2, to: date) ?? date)
        case "Sat":
            var satToMon = calendar.date(byAdding: .day, value: -5, to: date) ?? Date()
            mon = formatDate(date: satToMon)
            tue = formatDate(date: calendar.date(byAdding: .day, value: -4, to: date) ?? date)
            wed = formatDate(date: calendar.date(byAdding: .day, value: -3, to: date) ?? date)
            thu = formatDate(date: calendar.date(byAdding: .day, value: -2, to: date) ?? date)
            fri = formatDate(date: calendar.date(byAdding: .day, value: -1, to: date) ?? date)
            sat = today
            sun = formatDate(date: calendar.date(byAdding: .day, value: +1, to: date) ?? date)
        case "Sun":
            var sunToMon = calendar.date(byAdding: .day, value: -6, to: date) ?? Date()
            mon = formatDate(date: sunToMon)
            tue = formatDate(date: calendar.date(byAdding: .day, value: -5, to: date) ?? date)
            wed = formatDate(date: calendar.date(byAdding: .day, value: -4, to: date) ?? date)
            thu = formatDate(date: calendar.date(byAdding: .day, value: -3, to: date) ?? date)
            fri = formatDate(date: calendar.date(byAdding: .day, value: -2, to: date) ?? date)
            sat = formatDate(date: calendar.date(byAdding: .day, value: -1, to: date) ?? date)
            sun = today
        default:
            print("none of the days matches, that's weird 🤨", mon,tue,wed,thu,fri,sat,sun)
        }
    }
    
    mutating func formatDate(date: Date) -> String {
        var formatted: String
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "en-US")
        dateFormatter.setLocalizedDateFormatFromTemplate("EEE MMM d yyyy")
        formatted = dateFormatter.string(from: date)
        return formatted
    }
}

//check for the current date
//check to see if current date = monday, if it is not, then find out how to set the date to monday
//we now have monday - use monday as an anchor to determine, what the rest of the days of the week are


//core data
// --> if current date is monday, fetch the squat count
//fetch the squatentitylist to see if the current date has a count value
//fetch the current data
//filter through logSquatList to see if a current date + 1,2,3 days has exist
//if those days exist, grab those count values
//update count value in weeklyview




