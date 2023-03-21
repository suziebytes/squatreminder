//
//  ConfettiView.swift
//  SquatReminder
//
//  Created by Suzie on 3/21/23.
//

import UIKit
import ConfettiView

class Confetti: UIView {
    let colors = ColorManager()
    let confettiView = ConfettiView()
    
    func displayConfetti() {
        confettiView.emit(with: [
            .shape(.circle, colors.darkPurple),
            .shape(.triangle, colors.lightPurple),
            .shape(.square, colors.lightGray)
        ]) {_ in
            // Optional completion handler fires when animation finishes.
            print("hurray hurray")
        }
    }
}
