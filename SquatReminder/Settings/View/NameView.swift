//
//  NameView.swift
//  SquatReminder
//
//  Created by Suzie on 3/22/23.
//

import UIKit

class NameView: UIView {
    let colors = ColorManager()
    let headerLabel = SpacedLabel()
    let nameButton = Buttons()
    var welcomeView: WelcomeView?
    weak var settingsVC: SettingsVC? //define variable of type SettingsVC; weak prevents memory leak - make sure to go to SettingVC assign it to this property ->         nameView.settingsVC = self

    override init(frame: CGRect) {
        super .init(frame: frame)
        setupHeaderLabel()
        setupNameButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    
    func setupHeaderLabel() {
        addSubview(headerLabel)
//        headerLabel.setupLabel(inputText: "HEY YOU")
        headerLabel.textColor = colors.darkGray
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        headerLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
    }
    
    func setupNameButton() {
        addSubview(nameButton)
        nameButton.setTitle("ADD NAME", for: .normal)
        nameButton.addTarget(self, action: #selector(alertName), for: .touchUpInside)
        nameButton.backgroundColor = colors.lightPurple
        nameButton.translatesAutoresizingMaskIntoConstraints = false
        nameButton.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10).isActive = true
        nameButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        nameButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        nameButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        nameButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        nameButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    @objc func alertName() {
        let alertController = UIAlertController(title: "Hi! What's Your Name?", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            // configure the properties of the text field
            textField.placeholder = "Name"
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in
            print("User clicked Edit button")
        }))
        
        alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: {[self, weak alertController] (_) in
            let textField = alertController?.textFields![0]
            UserDefaults.standard.set(textField?.text ?? "", forKey: "key-name")
            let name = UserDefaults.standard.string(forKey: "key-name") ?? ""
            
            //use the key to grab value data (textField?.text)
            //to access the name: let name = UserDefaults.standard.string(forKey: "pp-name") ?? ""
            self.welcomeView?.setupNameLabel()
            self.nameButton.setTitle(name, for: .normal)
        }))
        //        UIApplication.shared.keyWindow?.window?.rootViewController
        settingsVC?.present(alertController, animated: true)
    }
}
