//
//  MaxSquatView.swift
//  SquatReminder
//
//  Created by Suzie on 2/4/23.
//

import UIKit

class MaxSquatView: UIView, UIPickerViewDelegate, UIPickerViewDataSource{
    
    let colors = ColorManager()
    let maxSquatLabel = UILabel()
    var maxSquatTextField = UITextField()
    var values = Array(0...100)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupMaxSquatLabel()
        setupNumberPicker()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMaxSquatLabel() {
        addSubview(maxSquatLabel)
        maxSquatLabel.text = "Max Squats Per Session"
        maxSquatLabel.textColor = colors.darkGray
        maxSquatLabel.font = UIFont(name:"HelveticaNeue", size: 15.0)
        
        maxSquatLabel.translatesAutoresizingMaskIntoConstraints = false
//        maxSquatLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        maxSquatLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        maxSquatLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    //MARK: UIPickerView
    func setupNumberPicker() {
        addSubview(maxSquatTextField)
        
        let numberPicker = UIPickerView()
        numberPicker.delegate = self
        numberPicker.dataSource = self
        maxSquatTextField.inputView = numberPicker
        maxSquatTextField.layer.cornerRadius = 12.5
        maxSquatTextField.textAlignment = .center
        maxSquatTextField.backgroundColor = colors.lightGray
        maxSquatTextField.layer.borderWidth = 1
        maxSquatTextField.borderStyle = .line
        maxSquatTextField.layer.borderColor = colors.darkGray.cgColor
        maxSquatTextField.clipsToBounds = true
    
        maxSquatTextField.translatesAutoresizingMaskIntoConstraints = false
        maxSquatTextField.topAnchor.constraint(equalTo: topAnchor).isActive = true
        maxSquatTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        maxSquatTextField.widthAnchor.constraint(equalToConstant: 75).isActive = true
        maxSquatTextField.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        maxSquatTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let row = values[row]
        return String(row)
    }
}
