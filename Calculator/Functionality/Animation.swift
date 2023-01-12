//
//  Animation.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 1/8/23.
//

import Foundation
import UIKit

class Animation: UIView {
    
    public func animateButton(sender: UIButton, colors: [CGFloat]) {
        sender.titleLabel!.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        let red = 71.0/255.0
        let blue = 71.0/255.0
        let green = 71.0/255.0
        let alpha = 1.0
        UIButton.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.40,
                         initialSpringVelocity: 5.0, options: [.allowUserInteraction],
                         animations: {
            sender.titleLabel!.transform = .identity
            sender.backgroundColor = UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
        } , completion: { _ in
            if sender.tag == 20 {
                sender.backgroundColor = UIColor.init(
                    red: 208.0/255.0,
                    green: 179.0/255.0,
                    blue: 170.0/255.0,
                    alpha: 1)
            } else {
                sender.backgroundColor = UIColor.init(
                    red: colors[0]/255.0,
                    green: colors[1]/255.0,
                    blue: colors[2]/255.0,
                    alpha: colors[3])
            }
        }
        )
    }
    public func animateErrorMessage(_ modelText: ErrorMessage, label: UILabel) -> Void {
        label.alpha = 1
        label.text = modelText.rawValue
        UIView.animate(withDuration: 3.1, delay: 0.1, options: .curveLinear, animations: { () -> Void in
            label.alpha = 0
        })
    }
}
