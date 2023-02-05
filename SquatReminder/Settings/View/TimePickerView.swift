//
//  TimePickerView.swift
//  SquatReminder
//
//  Created by Suzie on 2/5/23.
//

import UIKit

class TimePickerView: UIView {
    let colors = ColorManager()
    let startTimePicker = UIDatePicker()
    let endTimePicker = UIDatePicker()
     
    let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStackView()
        setupStackView()
        setupStartTimePicker()
        setupEndTimePicker()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureStackView() {
        addSubview(stackView)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func setupStackView() {
        stackView.addArrangedSubview(startTimePicker)
        stackView.addArrangedSubview(endTimePicker)
    }
    
    func setupStartTimePicker() {
        startTimePicker.tintColor = colors.darkPurple
        startTimePicker.datePickerMode = UIDatePicker.Mode.time

        startTimePicker.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupEndTimePicker() {
        endTimePicker.tintColor = colors.darkPurple
        endTimePicker.datePickerMode = UIDatePicker.Mode.time
        
        endTimePicker.translatesAutoresizingMaskIntoConstraints = false
    }
}
