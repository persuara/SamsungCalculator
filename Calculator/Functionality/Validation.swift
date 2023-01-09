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
    func validToParse(_ ourText: String) -> Bool {
        var flag: Bool = true
        var dignifiled = [String]()
        var arrayNum = ourText.matches(for: "(\\d)*(\\d*\\.?\\d*)*", in: ourText)
        arrayNum.forEach({ c in
            if c != "" {
                dignifiled.append(c)
            }
        })
        let arrayEle = ourText.matches(for: "[\\+\\-\\*\\/\\%]", in: ourText)
        if arrayEle.count != dignifiled.count - 1 {
            flag = false
        }
        return flag
    }
}
