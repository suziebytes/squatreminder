//
//  MonthView.swift
//  SquatReminder
//
//  Created by Suzie on 1/31/23.
//

import UIKit

@available(iOS 16.0, *)
class MonthView: UIView {
    
    let monthLabel = UILabel()
    let calendarView = UICalendarView()
    let cardView = CardView()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupMonthLabel()
        setupCardView()
        setupCalendar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMonthLabel() {
        addSubview(monthLabel)
        monthLabel.text = "M O N T H L Y"
        monthLabel.textColor = .black
        monthLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 15.0)
        
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        monthLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        monthLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func setupCardView() {
        addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 5).isActive = true
        cardView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }

    func setupCalendar(){
        cardView.addSubview(calendarView)
        calendarView.calendar = Calendar(identifier: .gregorian)
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        calendarView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        calendarView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
}
