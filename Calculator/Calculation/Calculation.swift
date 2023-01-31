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
                    lsn = array[element - 1]
                    print("Left side number: \(lsn)")
                    rsn = array[element + 1]
                    print("Right side number: \(rsn)")
                    if c == "%" {
                        result =  (Double(lsn) ?? 1) / 100
                    } else if c == "×" {
                        result =  (Double(lsn) ?? 1)  * (Double(rsn) ?? 1)
                    } else if c == "÷" {
                        result =  (Double(lsn) ?? 1) / (Double(rsn) ?? 1)
                    } else if c == "+" {
                        result =  (Double(lsn) ?? 1) + (Double(rsn) ?? 1)
                    } else if c == "–" {
                        result =  (Double(lsn) ?? 1) - (Double(rsn) ?? 1)
                    } else {
                        result = (Double(lsn) ?? 1)
                    }
                    if c == "%" {
                        array.remove(at: element - 1)
                        array.insert(String(result), at: element - 1)
                        print(" element: \(array[element])")
                        array.remove(at: element)
                    } else {
                        array.remove(at: element - 1)
                        array.insert(String(result), at: element - 1)
                        print(" element: \(array[element])")
                        array.remove(at: element + 1)
                        array.remove(at: element)
                    }
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
//        let doubleRes = displayLabel

        if displayLabel.containsParantheses() == false {
            print("Does not contain Any Para")
            let arrayend = arraifyIGNORE(text: displayLabel)
            return "\(arrayend[0])"
            
        } else if validate.isOnlyOneNumber(displayLabel) {
            print("*************** ONLY ONE NUMBER *******************")
                return "\(arrayToPass[1])"
            } else {
            indexOpen = arrayToPass.firstIndex(of: "(")!
            debugPrint("new indexOpen: \(indexOpen)")
            indexClose = arrayToPass.lastIndex(of: ")")! + 1
            debugPrint("new indexClose: \(indexClose)")
            let newValueArray = arrayToPass[indexOpen..<indexClose]
            let arrayNewValue = Array(newValueArray)
            let newValue = arrayNewValue.stringME()
            debugPrint("new value: \(newValue)")
            let regexed = newValue.matches(for: "\\(([^()\"]*(?:\"[^\"]*\"-?\\d+-?\\d+.-?\\d+[^()\"]*)*)\\)", in: newValue)
            print("Regexed: \(regexed)")
            if regexed.count != 0 {
                print("#1 regexed is not Empty")
                temp = validate.arraify(text: regexed[0])
                print("regexed[0] =  \(regexed[0])")
                tempString = temp.stringME()
                print("TempString: \(tempString)")
                temp = tempString.arraifyMe()
                print("temp ignore shode: \(temp)")
                result = calculate(array: &temp).truncate(places: 5)
                displayLabel = replaceOcc(this: displayLabel, of: regexed[0], with: result)
                print("DisplayLabel At the end of regex count != 0 ----> \(displayLabel)")
            } else {
                print("#2 else, Means Regexed.count != 0 ")
                temp = newValue.arraifyMe()
                if temp.count == 1 {
                    print("count == 1")
                    displayLabel = replaceOcc(this: displayLabel, of: "\(newValue)", with: Double(newValue)!)
                } else {
                    print("In ELSE TEMP arraified equal === \(temp)")
                    result = calculate(array: &temp).truncate(places: 5)
                    displayLabel = replaceOcc(this: displayLabel, of: newValue, with: result)
                }
                print("DisplayLabel At the end of regex count == 0 ----> \(displayLabel)")
            }
            print("At the end the displaylabel is: \(displayLabel)")
        }
        return advancedCalculationShit(this: &displayLabel)
    }
}
