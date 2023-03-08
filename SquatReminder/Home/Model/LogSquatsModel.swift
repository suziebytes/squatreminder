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
    var currentDate = CurrentDate()
    var squatEntityList: [SquatEntity] = [] // class type array for our entity
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    mutating func logDate() {
        let squatEntity = SquatEntity(context: appDelegate.persistentContainer.viewContext) // create new entity so we can access it
        
        //get current / today's date
        let todayDate = currentDate.getCurrentDate()
        let capToday = todayDate.uppercased()
        let currentDayOfWeek = currentDate.getDayOfWeek()
        
        // assign new date to date attribute
        squatEntity.date = capToday
        print("this is squatEntity.date🔥🔥🔥🔥🔥🔥🔥🔥 ", squatEntity.date ?? "") //print TUE, MAR 7, 2023
        //save todayDateb
    }
    
    func logCount() {
        let squatEntity = SquatEntity(context: appDelegate.persistentContainer.viewContext) // create new entity so we can access it
        
        //save count
        
        
    }
    
    func logIfSquatted() {
        
    }
}
