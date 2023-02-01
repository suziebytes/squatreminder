//
//  MonthView.swift
//  SquatReminder
//
//  Created by Suzie on 1/31/23.
//

import UIKit

//@available(iOS 16.0, *)
class MonthView: UIView {
    
    let monthLabel = UILabel()
//    let calendarView = UICalendarView()
    let card = CardView()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupMonthLabel()
//        setupCalendar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMonthLabel() {
        addSubview(monthLabel)
        monthLabel.text = "M O N T H L Y"
        monthLabel.textColor = .black
        monthLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 25.0)
        
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        monthLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        monthLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        monthLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
//    func setupCalendar(){
//        addSubview(calendarView)
//        calendarView.translatesAutoresizingMaskIntoConstraints = false
//        calendarView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//    }
    
}
