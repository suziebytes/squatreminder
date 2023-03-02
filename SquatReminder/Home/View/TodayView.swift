//
//  TodayView.swift
//  SquatReminder
//
//  Created by Suzie on 1/31/23.
//

import UIKit

class TodayView: UIView {
    let colors = ColorManager()
    let todayLabel = UILabel()
    let currentSquatButton = Buttons()
    var currentSquatLabel = DescriptionLabel()
    let dailySquatButton = Buttons()
    let dailySquatLabel = DescriptionLabel()
    var currentSquatCount = 0
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTodayLabel()
        setupCurrentLabel()
        setupCurrentSquatButton(count: currentSquatCount)
        setupDailyButton()
        setupDailyLabel()
        setupCurrentLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTodayLabel() {
        addSubview(todayLabel)
        todayLabel.text = "Today"
        todayLabel.textColor = .black
        todayLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 30.0)
        todayLabel.translatesAutoresizingMaskIntoConstraints = false
        todayLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        todayLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
    
    func setupCurrentSquatButton(count: Int){
        addSubview(currentSquatButton)
        let stringCount =  String(currentSquatCount)
        currentSquatButton.backgroundColor = colors.darkPurple
        currentSquatButton.tintColor = .white
        currentSquatButton.setTitle("\(currentSquatCount))", for: .normal)
        currentSquatButton.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 100)
        
        currentSquatButton.translatesAutoresizingMaskIntoConstraints = false
        currentSquatButton.topAnchor.constraint(equalTo: todayLabel.bottomAnchor, constant: 5).isActive = true
        currentSquatButton.heightAnchor.constraint(equalToConstant: 140).isActive = true
        currentSquatButton.widthAnchor.constraint(equalToConstant: 145).isActive = true
        currentSquatButton.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        currentSquatButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func setupCurrentLabel() {
        currentSquatButton.addSubview(currentSquatLabel)
        currentSquatLabel.setupLabel(labelTitle: "SQUATTED")
        currentSquatLabel.translatesAutoresizingMaskIntoConstraints = false
        currentSquatLabel.bottomAnchor.constraint(equalTo: currentSquatButton.bottomAnchor, constant: -5).isActive = true
        currentSquatLabel.centerXAnchor.constraint(equalTo: currentSquatButton.centerXAnchor).isActive = true
    }
    
    func setupDailyButton() {
        addSubview(dailySquatButton)
        let squatGoal = UserDefaults.standard.string(forKey: "key-goal") ?? ""
        dailySquatButton.backgroundColor = colors.darkPurple
        dailySquatButton.tintColor = .white
        dailySquatButton.setTitle(squatGoal, for: .normal)
        dailySquatButton.titleLabel?.adjustsFontSizeToFitWidth = true
        dailySquatButton.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 60)
        dailySquatButton.addTarget(self, action: #selector(updateSquatGoal), for: .touchUpInside)

        dailySquatButton.translatesAutoresizingMaskIntoConstraints = false
        dailySquatButton.heightAnchor.constraint(equalToConstant: 130).isActive = true
        dailySquatButton.widthAnchor.constraint(equalToConstant: 130).isActive = true
        dailySquatButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        dailySquatButton.topAnchor.constraint(equalTo: todayLabel.bottomAnchor, constant: 10).isActive = true
    }
    
    @objc func updateSquatGoal() {
        let alertController = UIAlertController(title: "Set Your Daily Squat Goal", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            // configure the properties of the text field
            textField.placeholder = "0"
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in
            print("User clicked Edit button")
        }))
        
        alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: {[self, weak alertController] (_) in
            let textField = alertController?.textFields![0]
            UserDefaults.standard.set(textField?.text ?? "", forKey: "key-goal")
            let squatGoal = UserDefaults.standard.string(forKey: "key-goal") ?? ""
            
            //use the key to grab value data (textField?.text)
            //to access the name: let name = UserDefaults.standard.string(forKey: "pp-name") ?? ""
            self.dailySquatButton.setTitle(squatGoal, for: .normal)
        }))
        
        UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    func setupDailyLabel() {
        dailySquatButton.addSubview(dailySquatLabel)
        dailySquatLabel.setupLabel(labelTitle: "DAILY GOAL")
        dailySquatLabel.translatesAutoresizingMaskIntoConstraints = false
        dailySquatLabel.bottomAnchor.constraint(equalTo: dailySquatButton.bottomAnchor, constant: -5).isActive = true
        dailySquatLabel.centerXAnchor.constraint(equalTo: dailySquatButton.centerXAnchor).isActive = true
    }
}
