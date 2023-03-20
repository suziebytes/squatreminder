//
//  WeeklyView.swift
//  SquatReminder
//
//  Created by Suzie on 1/31/23.
//

import UIKit
import BarChartKit
import CoreData

class WeeklyView: UIView {
    let colors = ColorManager()
    let weeklyLabel = SpacedLabel()
    let barChart = BarChartView()
    let stackView = UIStackView()
    let cardView = CardView()
    var currentDate = CurrentDate()
    var logSquatsModel = LogSquatsModel()
    var weeklyViewModel = WeeklyViewModel()
    var mon: String = ""
    var tue: String = ""
    var wed: String = ""
    var thu: String = ""
    var fri: String = ""
    var sat: String = ""
    var sun: String = ""

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCardView()
        configureStackView()
        setupStackView()
        setupWeeklyLabel()
        setupBarChart()
        setupBarChartStyling()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: STACKVIEW
    func configureStackView() {
        addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func setupStackView(){
        stackView.addArrangedSubview(weeklyLabel)
        stackView.addArrangedSubview(cardView)
    }
    
    //MARK: LABEL
    func setupWeeklyLabel() {
        weeklyLabel.setupLabel(inputText: "WEEKLY")
        weeklyLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: Current Date
    func getDate() -> String {
       return currentDate.getCurrentDate()
    }

    //MARK: CHART
    func setupCardView() {
        addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func getDaysOfWeek() {
        var today = getDate()
        weeklyViewModel.findMonday(today: today)
        
        //gets the date: String
        mon = weeklyViewModel.mon
        tue = weeklyViewModel.tue
        wed = weeklyViewModel.wed
        thu = weeklyViewModel.thu
        fri = weeklyViewModel.fri
        sat = weeklyViewModel.sat
        sun = weeklyViewModel.sun
    }
    
    func setupBarChart(){
        cardView.addSubview(barChart)
        getDaysOfWeek()
        var monCount: Double
        var tueCount: Double
        var wedCount: Double
        var thuCount: Double
        var friCount: Double
        var satCount: Double
        var sunCount: Double
        
        //Double - count values
        monCount = logSquatsModel.getCountBasedOnDate(day: mon)
        tueCount = logSquatsModel.getCountBasedOnDate(day: tue)
        wedCount = logSquatsModel.getCountBasedOnDate(day: wed)
        print("this is Wed squat count 😫", wedCount)
        thuCount = logSquatsModel.getCountBasedOnDate(day: thu)
        print("this is Thu squat count 😫", thuCount)
        friCount = logSquatsModel.getCountBasedOnDate(day: fri)
        print("this is Fri squat count 😫", friCount)
        satCount = logSquatsModel.getCountBasedOnDate(day: sat)
        sunCount = logSquatsModel.getCountBasedOnDate(day: sun)
        
        //get the squat count via coredata
        let loggedData: BarChartView.DataSet? = BarChartView.DataSet(elements: [
            .init(date: nil, xLabel: "SUN", bars: [.init(value: sunCount, color: colors.lightPurple)]),
            .init(date: nil, xLabel: "MON", bars: [.init(value: monCount, color: colors.lightPurple)]),
            .init(date: nil, xLabel: "TUE", bars: [.init(value: tueCount, color: colors.lightPurple)]),
            .init(date: nil, xLabel: "WED", bars: [.init(value: wedCount, color: colors.lightPurple)]),
            .init(date: nil, xLabel: "THU", bars: [.init(value: thuCount, color: colors.lightPurple)]),
            .init(date: nil, xLabel: "FRI", bars: [.init(value: friCount, color: colors.lightPurple)]),
            .init(date: nil, xLabel: "SAT", bars: [.init(value: satCount, color: colors.lightPurple)])
        ], selectionColor: colors.darkPurple)
        
        barChart.dataSet = loggedData
    }
    
    func setupBarChartStyling() {
        barChart.barWidth = 20
        barChart.translatesAutoresizingMaskIntoConstraints = false
        barChart.heightAnchor.constraint(equalToConstant: 150).isActive = true
        barChart.topAnchor.constraint(equalTo: cardView.topAnchor).isActive = true
        barChart.bottomAnchor.constraint(equalTo: cardView.bottomAnchor).isActive = true
        barChart.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 10).isActive = true
        barChart.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -10).isActive = true
    }
}
