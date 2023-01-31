//
//  Buttons.swift
//  SquatReminder
//
//  Created by Suzie on 1/30/23.
//

import UIKit

class Buttons: UIButton {
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupButton()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButton() {
        layer.cornerRadius = 15
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 5.0
    }
    
}

