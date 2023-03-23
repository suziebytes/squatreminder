//
//  SquatButton.swift
//  SquatReminder
//
//  Created by Suzie on 2/4/23.
//

import UIKit

class SquatButtonView: UIView {
    let colors = ColorManager()
    let squatButton = Buttons()
    let squatGoalLabel = DescriptionLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSquatButton()
        setupSquatGoalLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSquatButton() {
        addSubview(squatButton)
        
        let squatGoal = UserDefaults.standard.string(forKey: "key-goal") ?? ""
        
        squatButton.backgroundColor = colors.darkPurple
        squatButton.setTitle(squatGoal, for: .normal)
        squatButton.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 100)
        squatButton.addTarget(self, action: #selector(updateSquatGoal), for: .touchUpInside)
        
        squatButton.translatesAutoresizingMaskIntoConstraints = false
        squatButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        squatButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        squatButton.heightAnchor.constraint(equalToConstant: 150).isActive = true
        squatButton.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        squatButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        squatButton.widthAnchor.constraint(equalToConstant: 220).isActive = true
        squatButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    @objc func updateSquatGoal() {
        let alertController = UIAlertController(title: "Set Your Daily Squat Goal", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            // configure the properties of the text field
            textField.placeholder = "0"
            textField.keyboardType = .numberPad
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
            self.squatButton.setTitle(squatGoal, for: .normal)
            self.squatButton.titleLabel?.minimumScaleFactor = 0.5
            self.squatButton.titleLabel?.numberOfLines = 0
            self.squatButton.titleLabel?.adjustsFontSizeToFitWidth = true
        }))
        
        UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    func setupSquatGoalLabel() {
        squatButton.addSubview(squatGoalLabel)
        squatGoalLabel.setupLabel(labelTitle: "DAILY SQUAT GOAL")
        
        squatGoalLabel.translatesAutoresizingMaskIntoConstraints = false
        squatGoalLabel.bottomAnchor.constraint(equalTo: squatButton.bottomAnchor, constant: -5).isActive = true
        squatGoalLabel.centerXAnchor.constraint(equalTo: squatButton.centerXAnchor).isActive = true
    }
}
