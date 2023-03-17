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
    var logSquatsModel = LogSquatsModel()
    
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
    
    func createCalendar() {
        print("🔥")
        let calendar = Calendar.current
        //        let selectedDate = calendar.date(from: DateComponents(year: 2023, month: 03, day: 16))!
        
        let dateFormatter = DateFormatter()
        let date = Date()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        // Get current month's first and last day
        let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: date)
        let startDate = Calendar.current.date(from: comp)!
        var comps2 = DateComponents()
        comps2.month = 1
        comps2.day = -1
        let endDate = Calendar.current.date(byAdding: comps2, to: startDate) ?? startDate
        
        //Setting up spacing and design
        var content = CalendarViewContent(
            calendar: calendar,
            visibleDateRange: startDate...endDate,
            monthsLayout: .horizontal(options: HorizontalMonthsLayoutOptions()))
        
        content = content.interMonthSpacing(15)
        content = content.verticalDayMargin(5)
        content = content.horizontalDayMargin(5)
        
        //Day styling + selected date's indicator
        content = content.dayItemProvider { [calendar] day in
            var invariantViewProperties = DayView.InvariantViewProperties.baseNonInteractive
            invariantViewProperties.font = UIFont.systemFont(ofSize: 12)
            invariantViewProperties.textColor = self.colors.darkGray
            //changing color of single day selection
            let date = calendar.date(from: day.components)
            // if day is contained in my array that I fetched from core data,
            self.logSquatsModel.didSquat() //fetches data
            for element in self.logSquatsModel.newDates {
                var loggedDay = calendar.component(.day, from: element)
                var day = day.day //assign this so we can compare Int
                print("🔥 this is day ", day)
                print("🔥 loggedDay", loggedDay)
                
                if day == loggedDay {
                    invariantViewProperties.backgroundShapeDrawingConfig.borderColor = self.colors.darkPurple
                    invariantViewProperties.backgroundShapeDrawingConfig.fillColor = self.colors.darkPurple
                    invariantViewProperties.textColor = .white
                }
            }
            
            return DayView.calendarItemModel(
                invariantViewProperties: invariantViewProperties,
                viewModel: .init(
                    dayText: day.day.description,
                    accessibilityLabel: nil,
                    accessibilityHint: nil)
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
