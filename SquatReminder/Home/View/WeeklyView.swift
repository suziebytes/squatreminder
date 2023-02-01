//
//  WeeklyView.swift
//  SquatReminder
//
//  Created by Suzie on 1/31/23.
//

import UIKit
import BarChartKit

class WeeklyView: UIView {
    
    let colors = ColorManager()
    let weeklyLabel = UILabel()
    let barChart = BarChartView()
    let stackView = UIStackView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStackView()
        setupStackView()
        setupWeeklyLabel()
        setupBarChart()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: STACKVIEW
    func configureStackView() {
        addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func setupStackView(){
        stackView.addArrangedSubview(weeklyLabel)
        stackView.addArrangedSubview(barChart)
    }
     
    //MARK: LABEL
    func setupWeeklyLabel() {
//        addSubview(weeklyLabel)
        weeklyLabel.text = "W E E K L Y"
        weeklyLabel.textColor = .black
        weeklyLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 25.0)
        weeklyLabel.translatesAutoresizingMaskIntoConstraints = false
        weeklyLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    //MARK: CHART
    func setupBarChart(){
//        addSubview(barChart)
        let mockBarChartDataSet: BarChartView.DataSet? = BarChartView.DataSet(elements: [
            BarChartView.DataSet.DataElement(date: nil, xLabel: "SUN", bars:
                                                [BarChartView.DataSet.DataElement.Bar(value: 20000, color: colors.lightPurple)]),
            BarChartView.DataSet.DataElement(date: nil, xLabel: "MON", bars:
                                                [BarChartView.DataSet.DataElement.Bar(value: 0, color: colors.lightPurple)]),
            BarChartView.DataSet.DataElement(date: nil, xLabel: "TUES", bars:
                                                [BarChartView.DataSet.DataElement.Bar(value: 10000, color: colors.lightPurple)]),
            BarChartView.DataSet.DataElement(date: nil, xLabel: "WED", bars:
                                                [BarChartView.DataSet.DataElement.Bar(value: 20000, color: colors.lightPurple)]),
            BarChartView.DataSet.DataElement(date: nil, xLabel: "THUR", bars:
                                                [BarChartView.DataSet.DataElement.Bar(value: 32000, color: colors.lightPurple)]),
            BarChartView.DataSet.DataElement(date: nil, xLabel: "FRI", bars:
                                                [BarChartView.DataSet.DataElement.Bar(value: 20000, color: colors.lightPurple)]),
            BarChartView.DataSet.DataElement(date: nil, xLabel: "SAT", bars:
                                                [BarChartView.DataSet.DataElement.Bar(value: 20000, color: colors.lightPurple)])
        ], selectionColor: colors.darkPurple)
        
        barChart.barWidth = 20
        
        barChart.dataSet = mockBarChartDataSet
        barChart.translatesAutoresizingMaskIntoConstraints = false
        barChart.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
    }
}
