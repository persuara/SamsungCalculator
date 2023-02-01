//
//  Validation.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 1/8/23.
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
        var result = 0.0
        if textInQuestion == "-" {
            return 0
        } else {
            var dignified = [String]()
            let lastNum = textInQuestion!.matches(for: "(-?\\d)*(-?\\d*\\.?\\d*)", in: textInQuestion!)
            lastNum.forEach({ c in
                if c != "" {
                    dignified.append(c)
                }
            })
            if dignified.count != 0 {
                result = Double(dignified[dignified.count - 1]) ?? 1.0
            }
            return result
        }
    }
    public func negetateAndReplaceLastNum(_ textInQuestion: inout String) -> Void {
        let lastNum: Double = lastNumber(textInQuestion)
        print("here last num equallls: \(lastNum)")
        if lastNum.truncatingRemainder(dividingBy: 1) != 0 {
            if lastNum >= 0 {
                textInQuestion = textInQuestion.replacingOccurrences(of: "\(lastNum)", with: "(\(-1 * lastNum)")
            } else {
                textInQuestion = textInQuestion.replacingOccurrences(of: "(\(lastNum)", with: "\(-1 * lastNum)")
            }
        } else {
            if lastNum >= 0 {
                textInQuestion = textInQuestion.replacingOccurrences(of: "\(Int(lastNum))", with: "(\(Int(-1 * lastNum))")
            } else {
                textInQuestion = textInQuestion.replacingOccurrences(of: "(\(Int(lastNum))", with: "\(Int(-1 * lastNum))")
            }
        }
    }   
    func arraify(text expression: String) -> [String] {
        let inputNSString = expression as NSString
        var matchArray = [NSTextCheckingResult]()
        var sectionedArray = [String]()
        let range = NSRange(location: 0, length: expression.count)
        guard let sectioningRegex = try? NSRegularExpression(pattern:
                                                                "([-?\\d.\\d]+|[-?\\d]+)|([\\+\\–\\÷\\×\\%])|([\\)\\(]{1})") else { return ["wrong Jose"]}
        matchArray = sectioningRegex.matches(in: expression, range: range)
        for match in matchArray {
            let matchString = inputNSString.substring(with: match.range) as String
            sectionedArray.append(matchString)
        }
        return sectionedArray
    }
    func arraifyIGNORE(text expression: String) -> [String] {
        let inputNSString = expression as NSString
        var matchArray = [NSTextCheckingResult]()
        var sectionedArray = [String]()
        let range = NSRange(location: 0, length: expression.count)
        guard let sectioningRegex = try? NSRegularExpression(pattern:
                                                                "([-?\\d.\\d]+|[-?\\d]+)|([\\+\\–\\÷\\×\\%])") else { return ["wrong Jose"]}
        matchArray = sectioningRegex.matches(in: expression, range: range)
        for match in matchArray {
            let matchString = inputNSString.substring(with: match.range) as String
            sectionedArray.append(matchString)
        }
        return sectionedArray
    }
}
