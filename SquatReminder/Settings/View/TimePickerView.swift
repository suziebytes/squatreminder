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
    let startTimeLabel = HeaderLabel()
    let endTimeLabel = HeaderLabel()
     
    let startStackView = UIStackView()
    let endStackView = UIStackView()
    let stackViewContainer = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStartStackView()
        setupStartStackView()
        configureEndStackView()
        setupEndStackView()
        configureStackViewContainer()
        setupStackViewContainer()
        setupEndLabel()
        setupStartLabel()
        setupStartTimePicker()
        setupEndTimePicker()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: StackView Container
    func configureStackViewContainer() {
        addSubview(stackViewContainer)
        stackViewContainer.axis = .horizontal
        stackViewContainer.distribution = .fillEqually
        stackViewContainer.spacing = 10
        stackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        stackViewContainer.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackViewContainer.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackViewContainer.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        stackViewContainer.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func setupStackViewContainer() {
        stackViewContainer.addArrangedSubview(startStackView)
        stackViewContainer.addArrangedSubview(endStackView)
    }
    
    //MARK: Start View
    func configureStartStackView() {
        addSubview(startStackView)
        startStackView.axis = .vertical
        startStackView.alignment = .center
        startStackView.distribution = .fillEqually
        startStackView.spacing = 10
        startStackView.translatesAutoresizingMaskIntoConstraints = false
        startStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        startStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func setupStartStackView() {
        startStackView.addArrangedSubview(startTimeLabel)
        startStackView.addArrangedSubview(startTimePicker)
    }
    
    func setupStartLabel() {
        startTimeLabel.setupLabel(inputText: "START TIME")
        startTimeLabel.textColor = colors.darkPurple
        startTimeLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupStartTimePicker() {
        startTimePicker.tintColor = colors.darkPurple
        startTimePicker.datePickerMode = UIDatePicker.Mode.time
        startTimePicker.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: End View
    func configureEndStackView() {
        addSubview(endStackView)
        endStackView.axis = .vertical
        endStackView.distribution = .fillEqually
        endStackView.alignment = .center
        endStackView.spacing = 10
        endStackView.translatesAutoresizingMaskIntoConstraints = false
        endStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        endStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func setupEndStackView() {
        endStackView.addArrangedSubview(endTimeLabel)
        endStackView.addArrangedSubview(endTimePicker)
    }
    
    func setupEndLabel() {
        endTimeLabel.setupLabel(inputText: "END TIME")
        endTimeLabel.textColor = colors.darkPurple
        endTimeLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    func setupEndTimePicker() {
        endTimePicker.tintColor = colors.darkPurple
        endTimePicker.datePickerMode = UIDatePicker.Mode.time
        endTimePicker.translatesAutoresizingMaskIntoConstraints = false
    }
}
