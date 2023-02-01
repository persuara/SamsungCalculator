//
//  ViewModel.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 1/3/23.
//

import Foundation
class ViewModel {
    let arrayOfElements: [Character] = ["×","÷","+","-", "*", "/", "%","–"]
    let arrayOfNumbers: [Character] = ["0","1","2","3","4","5","6","7","8","9"]
    lazy var arrayOfArrays: [[ModelButton]] = [stack5Array, stack4Array, stack3Array, stack2Array, stack1Array]
    var iconArray: [ModelButton] = [.init(title: "clock", backGroundColor: [], font: "", size: 0), .init(title: "ruler", backGroundColor: [], font: "", size: 0),.init(title: "function", backGroundColor: [], font: "", size: 0)]
    var stack5Array: [ModelButton] = [.init(title: "C" ,titleColor: [240.0, 4.0, 6.0]), .init(title: "( )"), .init(title: "%"  ),.init(title: "÷"  , size: 37)]
    var stack4Array: [ModelButton] = [.init(title: "7"), .init(title: "8"), .init(title: "9"), .init(title: "×", size: 37)]
    var stack3Array: [ModelButton] = [.init(title: "4"), .init(title: "5"), .init(title: "6"), .init(title: "–", size: 37)]
    var stack2Array: [ModelButton] = [.init(title: "1"), .init(title: "2"), .init(title: "3"), .init(title: "+", size: 37)]
    var stack1Array: [ModelButton] = [.init(title: "+/–"), .init(title: "0"), .init(title: "."), .init(title: "=", backGroundColor: [197.0, 163.0, 154.0], titleColor: [24.0, 23.0, 23.0], size: 37)]
}
