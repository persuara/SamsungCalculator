//
//  ErrorMessage.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 1/8/23.
//

import Foundation
import UIKit
class ErrorSettings {
    
    public func showErrorMessage(_ modelText: ErrorMessage, which button: UIButton) {
        button.alpha = 1
        button.titleLabel?.text = modelText.rawValue
        UIView.animate(withDuration: 2.5, animations: { () -> Void in
            button.alpha = 0
        })
        button.reloadInputViews()
        UIButton.transition(with: button, duration: 2.5, animations: {
            button.titleLabel?.text = modelText.rawValue
        })
    }
}
enum ErrorMessage: String {
    
    case nothing = "Nothing to compute."
    case normal = "Invalid format used."

}
