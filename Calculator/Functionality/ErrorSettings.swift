//
//  ErrorMessage.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 1/8/23.
//

import Foundation
import UIKit
class ErrorSettings {
    
    public func showErrorMessage(_ modelText: ErrorMessage, which label: UILabel) {
        label.alpha = 1
        label.text = modelText.rawValue
        UIView.animate(withDuration: 2.5, animations: { () -> Void in
            label.alpha = 0
        })
//        
//        UIView.transition(with: label, duration: 2.5, animations: {
//            label.text = modelText.rawValue
//        })
    }
}
enum ErrorMessage: String {
    case error = "Couldn't Compute the given input!"
    case sameStatus = "Result stays the same!"
    case nothing = "WTF Comrade!"
    case normal = "Invalid format used."

}
