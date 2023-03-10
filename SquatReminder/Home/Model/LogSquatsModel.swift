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
            print("lets see the list 🌈", squatEntityList)
        } catch {
            print("Error fetching SquatEntity: \(error)")
        }
    }
    
    mutating func updateResults(tempCount: Int64) {
        let today = currentDate.currentDate
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
        } else { //if no entry for today's date, save today's date and the updated count
            //create new instance of SquatEntity
            let newEntity = SquatEntity(context: appDelegate.persistentContainer.viewContext)
            //assign the new values
            newEntity.date = today
            newEntity.count = tempCount
            appDelegate.saveContext()
        }
    }
}
