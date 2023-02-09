//
//  CardView.swift
//  SquatReminder
//
//  Created by Suzie on 2/1/23.
//

import UIKit

class CardView: UIView {
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupCard()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCard(){
        backgroundColor = .white
        layer.cornerRadius = 15
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 5.0
    }
}
