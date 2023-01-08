//
//  Animation.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 1/8/23.
//

import Foundation
import UIKit

class Animation: UIView {
    
    
    public func animateButton(sender: UIButton) {
        
        sender.titleLabel!.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        
        UIButton.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.40,
                       initialSpringVelocity: 4.0, options: .allowUserInteraction,
                       animations: {
            sender.titleLabel!.transform = .identity
                       }
        )
    }
}
