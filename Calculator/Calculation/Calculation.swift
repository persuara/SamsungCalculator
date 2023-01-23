//
//  Calculation.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 1/22/23.
//

import Foundation
class Calculator {
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
                        result =  (Double(rsn)! / 100) * Double(lsn)!
                    } else if c == "×" {
                        result =  Double(rsn)!  * Double(lsn)!
                    } else if c == "÷" {
                        result =  Double(rsn)! / Double(lsn)!
                    } else if c == "+" {
                        result =  Double(rsn)! + Double(lsn)!
                    } else if c == "–" {
                        result =  Double(rsn)! - Double(lsn)!
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
            if original[i] == "×" || original[i] == "÷" {
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
}
