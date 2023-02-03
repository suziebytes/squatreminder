//
//  SpacedLabel.swift
//  SquatReminder
//
//  Created by Suzie on 2/3/23.
//

import UIKit

class SpacedLabel: UILabel {
    let inputText: String = ""
 
    override init(frame: CGRect){
        super .init(frame: frame)
        setupLabel(inputText: "")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabel(inputText: String){
        attributedText = NSAttributedString(string: inputText, attributes: [.kern: 3.00])
        font = UIFont(name:"HelveticaNeue-Medium", size: 20.0)
        textColor = .black
    }
}
