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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCardView()
        configureStackView()
        setupStackView()
        setupWeeklyLabel()
        setupBarChart()
        setupBarChartStyling()
        getDate()
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
    func getDate() {
        let getCurrentDate = currentDate.getCurrentDate()
        let getDayOfWeek = currentDate.getDayOfWeek()
    }

    //MARK: CHART
    func setupCardView() {
        addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
    }
    
//    func fetchSquatCount() {
//
//    }
    
    func setupBarChart(){
        cardView.addSubview(barChart)
        
        let mon = Double(UserDefaults.standard.integer(forKey: "MON"))
        let tue = Double(UserDefaults.standard.integer(forKey: "TUES"))
        let wed = Double(UserDefaults.standard.integer(forKey: "WED"))
        let thu = Double(UserDefaults.standard.integer(forKey: "THU"))
        let fri = Double(UserDefaults.standard.integer(forKey: "FRI"))
        let sat = Double(UserDefaults.standard.integer(forKey: "SAT"))
        let sun = Double(UserDefaults.standard.integer(forKey: "SUN"))
        
        let mockBarChartDataSet: BarChartView.DataSet? = BarChartView.DataSet(elements: [
            .init(date: nil, xLabel: "SUN", bars: [.init(value: sun, color: colors.lightPurple)]),
            .init(date: nil, xLabel: "MON", bars: [.init(value: mon, color: colors.lightPurple)]),
            .init(date: nil, xLabel: "TUE", bars: [.init(value: tue, color: colors.lightPurple)]),
            .init(date: nil, xLabel: "WED", bars: [.init(value: wed, color: colors.lightPurple)]),
            .init(date: nil, xLabel: "THU", bars: [.init(value: thu, color: colors.lightPurple)]),
            .init(date: nil, xLabel: "FRI", bars: [.init(value: fri, color: colors.lightPurple)]),
            .init(date: nil, xLabel: "SAT", bars: [.init(value: sat, color: colors.lightPurple)])
        ], selectionColor: colors.darkPurple)
        
        barChart.dataSet = mockBarChartDataSet
    }
    
    func setupBarChartStyling() {
        barChart.barWidth = 30
        barChart.translatesAutoresizingMaskIntoConstraints = false
        barChart.heightAnchor.constraint(equalToConstant: 100).isActive = true
        barChart.topAnchor.constraint(equalTo: cardView.topAnchor).isActive = true
        barChart.bottomAnchor.constraint(equalTo: cardView.bottomAnchor).isActive = true
        barChart.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 10).isActive = true
        barChart.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -10).isActive = true
    }
}
