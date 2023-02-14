//
//  MonthView.swift
//  SquatReminder
//
//  Created by Suzie on 1/31/23.
//

import UIKit
import HorizonCalendar

class MonthView: UIView {
    
    let monthLabel = SpacedLabel()
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
        monthLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
    }
    
    private func createCalendar() {
        let calender = Calendar.current
        let startDate = calender.date(from: DateComponents(year: 2022, month: 2, day: 1))!
        let endDate = calender.date(from: DateComponents(year: 2022, month: 12, day: 31))!
        var content = CalendarViewContent(calendar: calender, visibleDateRange: startDate...endDate, monthsLayout: .horizontal(options: HorizontalMonthsLayoutOptions()))
        content = content.interMonthSpacing(15)
        content = content.verticalDayMargin(5)
        content = content.horizontalDayMargin(5)
        
        //Day styling
        content = content.dayItemProvider { day in
            var invariantViewProperties = DayView.InvariantViewProperties.baseNonInteractive
            invariantViewProperties.font = UIFont.systemFont(ofSize: 12)
            invariantViewProperties.textColor = self.colors.darkGray
            
            return DayView.calendarItemModel(
                invariantViewProperties: invariantViewProperties,
                viewModel: .init(dayText: day.day.description, accessibilityLabel: nil, accessibilityHint: nil)
            )
        }
        
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
        calendarView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        calendarView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        calendarView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        calendarView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
