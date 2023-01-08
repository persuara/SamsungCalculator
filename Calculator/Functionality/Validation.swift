//
//  Validation.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 1/8/23.
//

import Foundation
class Validation {
    lazy var viewModel = ViewModel()
    func isLastAnElement(_ text: String) -> Bool {
        var flag: Bool = false
        viewModel.arrayOfElements.forEach({ c in
            if text.last == c {
                flag = true
            }
        })
        return flag
    }
}
