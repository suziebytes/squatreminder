//
//  DescriptionLabel.swift
//  SquatReminder
//
//  Created by Suzie on 2/4/23.
//

import UIKit

class DescriptionLabel: UILabel {
    let labelTitle: String = ""
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel(labelTitle: "")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabel(labelTitle: String) {
        textColor = .white
        font = UIFont(name:"HelveticaNeue-Bold", size: 12.0) ?? nil
        text = labelTitle
    }
    
}
