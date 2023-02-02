//
//  MonthView.swift
//  SquatReminder
//
//  Created by Suzie on 1/31/23.
//

import UIKit

@available(iOS 16.0, *)
class MonthView: UIView, UICalendarViewDelegate {
    
    let monthLabel = UILabel()
    let calendarView = UICalendarView()
    let cardView = CardView()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupMonthLabel()
        setupCalendar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMonthLabel() {
        addSubview(monthLabel)
        monthLabel.text = "MONTHLY"
        monthLabel.textColor = .black
        monthLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        monthLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        monthLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func setupCalendar(){
        addSubview(calendarView)
        calendarView.calendar = Calendar(identifier: .gregorian)
        calendarView.locale = .current
        calendarView.fontDesign = .rounded
        calendarView.backgroundColor = .white
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 5.0
        calendarView.layer.cornerCurve = .continuous
        calendarView.layer.cornerRadius = 10.0
    
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 10).isActive = true
        calendarView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        calendarView.heightAnchor.constraint(equalToConstant: 250).isActive = true
    }
}
