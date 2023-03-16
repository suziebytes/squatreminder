//
//  LogSquats.swift
//  SquatReminder
//
//  Created by Suzie on 3/7/23.
//

import Foundation
import CoreData
import UIKit

struct LogSquatsModel {
    let currentDate = CurrentDate()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    // Fetch result of today's squatEntity.count
    let request: NSFetchRequest<SquatEntity> = SquatEntity.fetchRequest()
    // create squatList with empty array & fetch the result
    var squatEntityList: [SquatEntity] = []
    
    mutating func fetchData() {
        do {
            //fetches based on predicates / filters
            squatEntityList = try appDelegate.persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching SquatEntity: \(error)")
        }
    }
    
    mutating func updateResults(tempCount: Double) {
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
            //save updatedCount to Squat Entity
            appDelegate.saveContext()
            print("🤪updated entity")
        } else { //if no entry for today's date, save today's date and the updated count
            //create new instance of SquatEntity
            let newEntity = SquatEntity(context: appDelegate.persistentContainer.viewContext)
            //assign the new values
            newEntity.date = today
            newEntity.count = tempCount
            appDelegate.saveContext()
            print("🤪 created count / date ")
        }
    }
    
    mutating func getCountBasedOnDate(day: String) -> Double {
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
    
    func didSquat() {
        //fetch data
        //if date has count 
    }
}
