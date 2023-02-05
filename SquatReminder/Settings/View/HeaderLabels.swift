//
//  HeaderLabels.swift
//  SquatReminder
//
//  Created by Suzie on 2/5/23.
//

import UIKit

class HeaderLabel: UILabel {
    let colors = ColorManager()
    let inputText: String = ""
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setupLabel(inputText: "")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabel(inputText: String) {
        attributedText = NSAttributedString(string: inputText, attributes: [.kern: 2.00])
      font = UIFont(name:"HelveticaNeue-Bold", size: 14.0)
       textColor = colors.darkGray
    }
}
