//
//  ErrorMessage.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 1/8/23.
//

import Foundation
import UIKit
class ErrorSettings {
    var label = UILabel()
    var viewModel = ViewModel()
    var lastElement = Validation()
    public func showErrorMessage(_ modelText: ErrorMessage, which label: UILabel) {
        label.alpha = 1
        label.text = modelText.rawValue
        UIView.animate(withDuration: 2.5, animations: { () -> Void in
            label.alpha = 0
        })
    }
    
    public func displayErrorMessage(_ modelText: ErrorMessage, from text: String?) {
          if text == nil {
              label.alpha = 1
              label.text = modelText.rawValue
              UIView.animate(withDuration: 3.1, delay: 0.1, options: .curveLinear ,animations: { () -> Void in
                  self.label.alpha = 0
              })
          } else {
              if lastElement.validToParse(text!) != true {
                  label.alpha = 1
                  label.text = modelText.rawValue
                  UIView.animate(withDuration: 3.1, delay: 0.1, options: .curveLinear, animations: { () -> Void in
                      self.label.alpha = 0
                  })
              }
              viewModel.arrayOfElements.forEach({ c in
                  if text?.last == c {
                      label.alpha = 1
                      label.text = modelText.rawValue
                      UIView.animate(withDuration: 3.1, delay: 0.1, options: .curveLinear, animations: { () -> Void in
                          self.label.alpha = 0
                      })
                  }
              })
          }
      }
    
}
enum ErrorMessage: String {
    case error = "Couldn't Compute the given input!"
    case sameStatus = "Result stays the same!"
    case nothing = "Nothing to compute"
    case normal = "Invalid format used."

}
