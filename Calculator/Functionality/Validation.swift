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
    func isLastANumber(_ text: String) -> Bool {
        var flag: Bool = false
        viewModel.arrayOfNumbers.forEach({ c in
            if text.last == c {
                flag = true
            }
        })
        return flag
    }
    func isOnlyOneNumber(_ textInQuestion: String) -> Bool {
        var flag: Bool = false
        var dignifiled = [String]()
        let arrayNum = textInQuestion.matches(for:  "(\\d)*(\\d*\\.?\\d*)", in: textInQuestion)
        arrayNum.forEach({ c in
            if c != "" {
                dignifiled.append(c)
            }
        })
        if dignifiled.count == 1 {
            flag = true
        }
        return flag
    }
    public func lastNumber(_ textInQuestion: String) -> Double {
        var dignified = [String]()
        let arrayNum = textInQuestion.matches(for:  "(\\d)*(\\d*\\.?\\d*)", in: textInQuestion)
        arrayNum.forEach({ c in
            if c != "" {
                dignified.append(c)
            }
        })
        return Double(dignified[dignified.count - 1]) ?? 0
    }
    
    public func negetateAndReplaceLastNum(_ textInQuestion: inout String) -> Void {
        let lastNum: Double = lastNumber(textInQuestion)
        if lastNum.truncatingRemainder(dividingBy: 1) != 0 {
            textInQuestion = textInQuestion.replacingOccurrences(of: "\(lastNum)", with: "(-\(lastNum))")
        } else {
            textInQuestion = textInQuestion.replacingOccurrences(of: "\(Int(lastNum))", with: "(-\(Int(lastNum))")
        }
    }
    func changeText(_ text: String? ) -> String {
        var endResult = ""
        guard text != nil else {return "" }
        if (isOnlyOneNumber(text!) == true) && (isLastANumber(text!) == true) {
            endResult = "\(text!)*("
        }
        return endResult
    }
    
    func validToParse(_ ourText: String) -> Bool {
        var flag: Bool = true
        var dignifiled = [String]()
        let arrayNum = ourText.matches(for: "(\\d)*(\\d*\\.?\\d*)*", in: ourText)
        print("ArrayNum in Valid to parse method: \(arrayNum)")
        arrayNum.forEach({ c in
            if c != "" {
                dignifiled.append(c)
            }
        })
        let arrayEle = ourText.matches(for: "[\\+\\-\\*\\/\\%]", in: ourText)
        print("array of Elements in Valid to parse method: \(arrayEle)")
        print("diginified Set in Valid to parse method: \(dignifiled)")
        if arrayEle.count > dignifiled.count  {
            flag = false
        }
        return flag
    }
    public func placeArithmicElementifOnlyOneNumber(_ text: inout String, which element: String) -> Void {
        if isOnlyOneNumber(text) {
            text = "\(text)\(element)("
        }
    }
}
