//
//  Leftover.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 1/5/23.
//

import Foundation
class Leftover {
    
    public func sameParanthesesCount(_ text:  String ) -> Bool {
        var flag: Bool = true
        if numOfLeftFacingParantheses(text) != numOfRightFacingParantheses(text) {
            flag = false
        }
        return flag
    }
    
    private func numOfRightFacingParantheses(_ thistext: String) -> Int {
        let array = thistext.matches(for: "\\(", in: thistext)
        return array.count
    }
    private func numOfLeftFacingParantheses(_ thistext: String) -> Int {
        let array = thistext.matches(for: "\\)", in: thistext)
        return array.count
    }
    
    private func diffInParanthesesCount(_ textInQuestion:  String) -> Int {
        var number: Int = 0
        number = numOfRightFacingParantheses(textInQuestion) - numOfLeftFacingParantheses(textInQuestion)
        return abs(number)
    }


    public func placeParatheses(_ text: String) -> String{
        var endResultString: String = ""
        if diffInParanthesesCount(text) > 0 {
            for _ in 0...numOfRightFacingParantheses(text) - 1 {
                endResultString = "\(endResultString))"
            }
        } else if diffInParanthesesCount(text) > 0 {
            for _ in 0...numOfLeftFacingParantheses(text) - 1 {
                endResultString = "\(endResultString)("
            }
        }
        return endResultString
    }
}
