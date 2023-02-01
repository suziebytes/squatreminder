//
//  MonthView.swift
//  SquatReminder
//
//  Created by Suzie on 1/31/23.
//

import UIKit

class MonthView: UIView {
    
    let monthLabel = UILabel()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupMonthLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMonthLabel() {
        addSubview(monthLabel)
        monthLabel.text = "M O N T H L Y"
        monthLabel.textColor = .black
        monthLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 25.0)
        
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        monthLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        monthLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        monthLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
}
