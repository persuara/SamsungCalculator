//
//  ErrorMessage.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 1/8/23.
import Foundation
import UIKit
class ErrorSettings {
    var label = UILabel()
    lazy var viewModel = ViewModel()
    lazy var validate = Validation()
    lazy var animate = Animation()
    public func displayErrorMessage(_ modelText: ErrorMessage) {
        animate.animateErrorMessage(modelText, label: label)
    }
}
enum ErrorMessage: String {
    case error = "No Way Jose!"
    case sameStatus = "Result stays the same!"
    case nothing = "Bro, type sth first!"
    case normal = "Invalid format used."
}
