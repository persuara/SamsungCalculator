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
    lazy var animate = Animation()
    
    public func displayErrorMessage(_ modelText: ErrorMessage, from text: String?) {
          if text == nil {
              animate.animateErrorMessage(modelText, label: label)
          } else {
              if lastElement.validToParse(text!) != true {
                  animate.animateErrorMessage(modelText, label: label)
              }
              viewModel.arrayOfElements.forEach({ c in
                  if text?.last == c {
                      animate.animateErrorMessage(modelText, label: label)
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
