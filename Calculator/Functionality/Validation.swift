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
    public func lastNumber(_ textInQuestion: String?) -> Double {
        guard textInQuestion != nil else { return 0 }
        if textInQuestion == "-" {
            return 0
        } else {
            var dignified = [String]()
            let lastNum = textInQuestion!.matches(for: "(\\d)*(\\d*\\.?\\d*)", in: textInQuestion!)
            lastNum.forEach({ c in
                if c != "" {
                    dignified.append(c)
                }
            })
            return Double(dignified[dignified.count - 1])!
        }
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
        let arrayAgain = ourText.matches(for: "\\(\\)$", in: ourText)
        print(arrayAgain)
        
        let arrayTest = ourText.matches(for: "\\([\\+\\*\\/]", in: ourText)
        if  arrayAgain.count != 0 || arrayTest.count != 0  {
            return false
        } else {
            let arrayNum = ourText.matches(for: "(\\d)*(\\d*\\.?\\d*)*", in: ourText)
            arrayNum.forEach({ c in
                if c != "" {
                    dignifiled.append(c)
                }
            })
            let arrayEle = ourText.matches(for: "[\\+\\-\\*\\/\\%]", in: ourText)
            if arrayEle.count == dignifiled.count || arrayEle.count > dignifiled.count + 1 {
                flag = false
            }
            return flag
        }
    }
    public func placeArithmicElementifOnlyOneNumber(_ text: inout String, which element: String) -> Void {
            text = "\(text)\(element)("
        
    }
    
    public func findlastPercentage(_ text: String, flag: inout Bool ) -> String {
        let array = text.matches(for: "(\\/100\\*)+", in: text)
        
        if array.count > 0 {
            flag = true
            print("flag\(flag)")
        } else {
            return ""
        }
        return array[array.count - 1]
    }
}
