//
//  Animation.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 1/8/23.
import Foundation
import UIKit
class Animation: UIView {
    public func animateButton(sender: UIButton, colors: [CGFloat]) {
        sender.titleLabel!.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        let colorScheme = 71.0/255.0
        let red = colorScheme
        let blue = colorScheme
        let green = colorScheme
        let alpha = 1.0
        UIButton.animate(withDuration: 0.3, delay: 0, animations: {
            sender.titleLabel!.transform = .identity
            sender.backgroundColor = UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
        } , completion: { _ in
            UIButton.animate(withDuration: 0.1, delay: 0, options: [.allowUserInteraction] ,animations: {
                if sender.tag == 20 {
                    sender.backgroundColor = UIColor.init(red: 208.0/255.0, green: 179.0/255.0, blue: 170.0/255.0, alpha: 1)
                } else {
                    sender.backgroundColor = UIColor.init(red: colors[0]/255.0, green: colors[1]/255.0, blue: colors[2]/255.0, alpha: colors[3])
                }
            })
        })
    }
    public func animateErrorMessage(_ modelText: ErrorMessage, label: UILabel) -> Void {
        label.alpha = 1
        label.text = modelText.rawValue
        UIView.animate(withDuration: 3.1, delay: 0.1 , animations: { () -> Void in
            label.alpha = 0
        })
    }
}
