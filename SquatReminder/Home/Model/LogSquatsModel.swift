//
//  LogSquats.swift
//  SquatReminder
//
//  Created by Suzie on 3/7/23.
//

import Foundation
import CoreData
import UIKit
import ConfettiView

class LogSquatsModel {
    let colors = ColorManager()
    let currentDate = CurrentDate()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    // Fetch result of today's squatEntity.count
    let request: NSFetchRequest<SquatEntity> = SquatEntity.fetchRequest()
    // create squatList with empty array & fetch the result
    var squatEntityList: [SquatEntity] = []
    var dateString: String = ""
    var newDates: [Date] = []
    var todayView = TodayView()
    var currentCount = 0
    var homeVC: HomeVC?
    
    func fetchData() {
        do {
            //fetches based on predicates / filters
            squatEntityList = try appDelegate.persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching SquatEntity: \(error)")
        }
    }
    
    func updateResults(tempCount: Double) {
        let today = currentDate.getCurrentDate()
        // set the filter - filter should check for today's date and the current count for today
        let predicate = NSPredicate(format: "date == %@", today)
        //apply fetch request with filter
        request.predicate = predicate
        
        fetchData()
        if squatEntityList.count > 0 {
            //the first element is the first element of the Squat Entity array, which contains two properties (count and  date)
            guard let previousSquatEntity = squatEntityList.first else {
                return
            }
            let previousCount = previousSquatEntity.count
            //var date = previousSquatEntity.date
            let updateCount = previousCount + tempCount
            //override the entity we received from our filtered request with the previous count with new count
            previousSquatEntity.count = updateCount
            currentCount = Int(updateCount)
            //save updatedCount to Squat Entity
            appDelegate.saveContext()
            homeVC?.displayConfetti()
            print("🤪updated entity")
        } else { //if no entry for today's date, save today's date and the updated count
            //create new instance of SquatEntity
            let newEntity = SquatEntity(context: appDelegate.persistentContainer.viewContext)
            //assign the new values
            newEntity.date = today
            newEntity.count = tempCount
            currentCount = Int(tempCount)
            appDelegate.saveContext()
            homeVC?.displayConfetti()
        }
    }
    
    func getCountBasedOnDate(day: String) -> Double {
        let predicate = NSPredicate(format: "date == %@", day)
        var count: Double = 0
        
        request.predicate = predicate
        fetchData()
        
        if squatEntityList.count > 0 {
            guard let day = squatEntityList.first else {
                return count
            }
            count = day.count
        }
        return count
    }
    
    func didSquat(){
        let today = Date()
        var dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMM"
        var stringMonth = dateFormatter.string(from: today) //prints "Mar"
        dateFormatter.dateFormat = "YYYY"
        var stringYear = dateFormatter.string(from:today)
        //filter for the month matching current month
        let predicate = NSPredicate(format: "date CONTAINS[cd] '\(stringMonth)' AND date CONTAINS[cd] '\(stringYear)'")
        
        request.predicate = predicate
        fetchData()
        
        //check if there is data stored - squatEntityList is the array with all values
        if squatEntityList.count > 0 {
            //loop through array
            for element in squatEntityList {
                let dateString = element.date ?? "" //gets each element's date property
                dateFormatter.locale = Locale(identifier: "en-US")
                dateFormatter.setLocalizedDateFormatFromTemplate("EEE MMM d yyyy") //lets formatter know this is the format of the received string
                let date = dateFormatter.date(from: dateString) // converts the dataString to a date object
//                print("this is the date 🥶🥶🥶🥶 \(String(describing: date))")
                let calendar = Calendar.current
                //gets all the components
                let components = calendar.dateComponents([.year, .month, .day], from: date ?? Date())
                //gets specific components
                var year = calendar.component(.year , from: date!)
                var month = calendar.component(.month, from: date!)
                var day = calendar.component(.day, from: date!)
                
                var stringToDate = calendar.date(from: DateComponents(year: year, month: month, day: day))!
//                print("this is the date 🌈🌈🌈 \(stringToDate)")
                
                newDates.append(stringToDate)
            }
        }
    }
}
