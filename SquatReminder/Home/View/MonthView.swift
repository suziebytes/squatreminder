//
//  MonthView.swift
//  SquatReminder
//
//  Created by Suzie on 1/31/23.
//

import UIKit
import HorizonCalendar

@available(iOS 16.0, *)
class MonthView: UIView {
    
    let monthLabel = SpacedLabel()
    //    let calendarView = UICalendarView()
    let cardView = CardView()
    let colors = ColorManager()
    
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupMonthLabel()
        createCalendar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMonthLabel() {
        addSubview(monthLabel)
        monthLabel.setupLabel(inputText: "MONTH")
   
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        monthLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        monthLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    private func createCalendar() {
        let calender = Calendar.current
        let startDate = calender.date(from: DateComponents(year: 2022, month: 2, day: 1))!
        let endDate = calender.date(from: DateComponents(year: 2022, month: 12, day: 31))!
        var content = CalendarViewContent(calendar: calender, visibleDateRange: startDate...endDate, monthsLayout: .horizontal(options: HorizontalMonthsLayoutOptions()))
        content = content.interMonthSpacing(20)
        content = content.verticalDayMargin(5)
        content = content.horizontalDayMargin(5)
    
        let calendarView = CalendarView(initialContent: content)
        calendarView.tintColor = colors.darkGray
        
        addSubview(calendarView)
        
        calendarView.layer.cornerRadius = 15
        calendarView.layer.shadowColor = UIColor.darkGray.cgColor
        calendarView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        calendarView.layer.shadowOpacity = 0.3
        calendarView.layer.shadowRadius = 5.0
        
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 5).isActive = true
        calendarView.rightAnchor.constraint(equalTo: rightAnchor, constant: 5).isActive = true
        calendarView.leftAnchor.constraint(equalTo: leftAnchor, constant: -5).isActive = true
        calendarView.heightAnchor.constraint(equalToConstant: 250).isActive = true
    }
    
    //    func setupCalendar(){
    //        addSubview(calendarView)
    //        calendarView.calendar = Calendar(identifier: .gregorian)
    //        calendarView.locale = .current
    //        calendarView.fontDesign = .rounded
    //        calendarView.backgroundColor = .white
    //        layer.shadowColor = UIColor.darkGray.cgColor
    //        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
    //        layer.shadowOpacity = 0.4
    //        layer.shadowRadius = 5.0
    //        calendarView.layer.cornerCurve = .continuous
    //        calendarView.layer.cornerRadius = 10.0
    //        calendarView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    //
    //        calendarView.translatesAutoresizingMaskIntoConstraints = false
    //        calendarView.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 10).isActive = true
    //        calendarView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    //        calendarView.heightAnchor.constraint(equalToConstant: 250).isActive = true
    //    }
}
