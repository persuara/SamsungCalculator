//
//  Calculation.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 1/22/23.
//

import Foundation
class Calculator {
    lazy var validate = Validation()
    
    var rsn: String = ""
    var lsn: String = ""
    public func calculate(array: inout [String]) -> Double {
        var element: Int = 0
        var result: Double = 0
        let arrayElements = sortEndResult(array, from: sortMultAndDiv(array))
        arrayElements.forEach({ c in
            if array.count == 1 {
                print(result)
            } else {
                if array.contains(c) {
                    element = array.firstIndex(of: c)!
                    rsn = array[element - 1]
                    print("Right side number: \(rsn)")
                    lsn = array[element + 1]
                    print("left side number: \(lsn)")
                    if c == "%" {
                        result =  (Double(rsn)! / 100) * (Double(lsn) ?? 1)
                    } else if c == "×" {
                        result =  (Double(rsn) ?? 1)  * (Double(lsn) ?? 1)
                    } else if c == "÷" {
                        result =  (Double(rsn) ?? 1) / (Double(lsn) ?? 1)
                    } else if c == "+" {
                        result =  (Double(rsn) ?? 1) + (Double(lsn) ?? 1)
                    } else if c == "–" {
                        result =  (Double(rsn) ?? 1) - (Double(lsn) ?? 1)
                    }
                    array.remove(at: element - 1)
                    array.insert(String(result), at: element - 1)
                    print(" element: \(array[element])")
                    array.remove(at: element + 1)
                    array.remove(at: element)
                    print(array)
                }
            }
        })
        return result
    }
    func sortMultAndDiv(_ array: [String]) -> [String] {
        var sortedMultAndDiv = [String]()
        let original = array
        for i in 0...original.count - 1 {
            if original[i] == "×" || original[i] == "÷" || original[i] == "%" {
                sortedMultAndDiv.append(original[i])
            }
        }
        return sortedMultAndDiv
    }
    func sortEndResult(_ array: [String], from sortedMultAndDiv: [String]) -> [String] {
        var finalSorted = [String]()
        let original = array
        finalSorted = sortedMultAndDiv
        for i in 0...original.count - 1 {
            if original[i] == "+" || original[i] == "–" {
                finalSorted.append(original[i])
            }
        }
        return finalSorted
    }
    private func gatherAllElmentsOfTheArray(_ array: [String]) -> [String] {
        return (array.description).matches(for: "[\\+\\–\\×\\÷\\%]", in: array.description)
    }
    func arraifyIGNORE(text expression: String) -> [String] {
        let inputNSString = expression as NSString
        var matchArray = [NSTextCheckingResult]()
        var sectionedArray = [String]()
        let range = NSRange(location: 0, length: expression.count)
        guard let sectioningRegex = try? NSRegularExpression(pattern:
                                                                "([\\d.\\d]+|[\\d]+)|([\\+\\–\\÷\\×\\%])") else { return ["wrong Jose"]}
        matchArray = sectioningRegex.matches(in: expression, range: range)
        for match in matchArray {
            let matchString = inputNSString.substring(with: match.range) as String
            sectionedArray.append(matchString)
        }
        return sectionedArray
    }
    func replaceOcc(this text: String,of str: String ,with result: Double) -> String {
        return text.replacingOccurrences(of: str, with: "\(result)")
    }
    public func advancedCalculationShit(this displayLabel: inout String) -> String {
        var arrayToPass = displayLabel.arraifyMe()
        var temp = [String]()
        var tempString : String = ""
        var result: Double = 0.0
        var indexOpen: Int = 0
        var indexClose: Int = 0
        let doubleRes = displayLabel
        
        if Double(doubleRes) != nil {
            return "\(displayLabel)"
        }
        if displayLabel.containsParantheses() == false {
            return "\(calculate(array: &arrayToPass))"
        } else {
            indexOpen = arrayToPass.firstIndex(of: "(")! + 1
            debugPrint("new indexOpen: \(indexOpen)")
            indexClose = arrayToPass.lastIndex(of: ")")! + indexOpen
            debugPrint("new indexClose: \(indexClose)")
            let newValue = displayLabel[indexOpen..<indexClose]
            debugPrint("new value: \(newValue)")
            let regexed = newValue.matches(for: "\\(([^()\"]*(?:\"[^\"]*\"\\d+\\d+.\\d+[^()\"]*)*)\\)", in: newValue)
            print("Regexed: \(regexed)")
            if regexed.count != 0 {
                print("regexed is not empty baby-----------")
                temp = validate.arraify(text: regexed[0])
                tempString = temp.stringME()
                debugPrint(tempString)
                temp = arraifyIGNORE(text: tempString)
                debugPrint(temp)
                result = calculate(array: &temp)
                displayLabel = replaceOcc(this: displayLabel, of: regexed[0], with: result)
            } else {
                print("else is being run baby*************")
                temp = newValue.arraifyMe()
                result = calculate(array: &temp)
                displayLabel = replaceOcc(this: displayLabel, of: "(\(newValue))", with: result)
            }
            print("At the end the displaylabel is: \(displayLabel)")
        }
        return advancedCalculationShit(this: &displayLabel)
    }
}
