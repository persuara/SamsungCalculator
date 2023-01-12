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
    
    public func diffInParanthesesCount(_ textInQuestion:  String) -> Int {
        var number: Int = 0
        number = numOfRightFacingParantheses(textInQuestion) - numOfLeftFacingParantheses(textInQuestion)
        return number
    }
    
    public func placeParatheses(_ text: String) -> String{
        var endResultString: String = ""
        var numRight = numOfRightFacingParantheses(text) - 1
        var numLeft = numOfLeftFacingParantheses(text) - 1
        if numRight < 0 {
            numRight = 1
        } else if numLeft < 0 {
            numLeft = 1
        }

        if diffInParanthesesCount(text) > 0 {
            for _ in 0...numRight {
                endResultString = "\(endResultString))"
            }
        } else if diffInParanthesesCount(text) < 0 {
            for _ in 0...numLeft {
                endResultString = "(\(endResultString)"
            }
        }
        return endResultString
    }
}
