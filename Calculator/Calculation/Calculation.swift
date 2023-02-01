//
//  Calculation.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 1/22/23.
import Foundation
class Calculator {
    lazy var validate = Validation()
    var rsn: String = ""
    var lsn: String = ""
    public func calculate(array: inout [String]) -> Double {
        var element: Int = 0
        var result: Double = 0
        let arrayElements = sortEndResult(array, from: sortMultAndDiv(array))
        if array.count == 1  {
            let toPass = array[0]
            result = Double(toPass) ?? -1
        } else {
            arrayElements.forEach({ c in
                if array.count == 1 {
                    print(result)
                } else {
                    if array.contains(c) {
                        element = array.firstIndex(of: c) ?? 1
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
        }
        return result
    }
    func sortMultAndDiv(_ array: [String]) -> [String] {
        var sortedMultAndDiv = [String]()
        let original = array
        if original.count != 0 {
            for i in 0...original.count - 1 {
                if original[i] == "×" || original[i] == "÷" || original[i] == "%" {
                    sortedMultAndDiv.append(original[i])
                }
            }
        }
        return sortedMultAndDiv
    }
    func sortEndResult(_ array: [String], from sortedMultAndDiv: [String]) -> [String] {
        var finalSorted = [String]()
        let original = array
        finalSorted = sortedMultAndDiv
        if original.count != 0 {
            for i in 0...original.count - 1 {
                if original[i] == "+" || original[i] == "–" {
                    finalSorted.append(original[i])
                }
            }
        }
        return finalSorted
    }
    private func gatherAllElmentsOfTheArray(_ array: [String]) -> [String] {
        return (array.description).matches(for: "[\\+\\–\\×\\÷\\%]", in: array.description)
    }
    func replaceOcc(this text: String,of str: String ,with result: Double) -> String {
        return text.replacingOccurrences(of: str, with: "\(result)")
    }
    public func advancedCalculationShit(this displayLabel:  String) -> String {
        var substitude = displayLabel
        let arrayToPass = substitude.arraifyMe()
        var temp = [String]()
        var tempString : String = ""
        var result: Double = 0.0
        var indexOpen: Int = 0
        var indexClose: Int = 0
        if substitude.containsParantheses() == false {
            print("Does not contain Any Para")
            var arrayaga = validate.arraifyIGNORE(text: substitude)
            print("array without para: \(arrayaga)")
            return "\(calculate(array: &arrayaga).truncate(places: 5))"
            
        } else if validate.isOnlyOneNumber(substitude) {
            print("*************** ONLY ONE NUMBER *******************")
            let arraha = substitude.matches(for: "((-?\\d)+(-?\\d*\\.?\\d*)){1}", in: substitude)
                return "\(arraha[0])"
            } else {
                indexOpen = arrayToPass.firstIndex(of: "(") ?? 0
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
                let test = tempString.matches(for: "((-?\\d)+(-?\\d*\\.?\\d*)){1}", in: tempString)
                print("TempString: \(tempString)")
                temp = tempString.arraifyMe()
                if test.count != 1 {
                    result = calculate(array: &temp).truncate(places: 5).truncate(places: 5)
                } else {
                    result = Double(test[0]) ?? 0
                }
                substitude = replaceOcc(this: substitude, of: regexed[0], with: result)
                print("substitude At the end of regex count != 0 ----> \(substitude)")
            } else {
                print("#2 else, Means Regexed.count != 0 ")
                temp = newValue.arraifyMe()
                if temp.count == 1 {
                    print("count == 1")
                    substitude = replaceOcc(this: substitude, of: "\(newValue)", with: Double(newValue)!)
                } else {
                    print("In ELSE TEMP arraified equal === \(temp)")
                    result = calculate(array: &temp).truncate(places: 5)
                    substitude = replaceOcc(this: substitude, of: newValue, with: result)
                }
            }
            print("------- Substituded is: \(substitude)")
        }
        return advancedCalculationShit(this: substitude)
    }
}
