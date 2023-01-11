//
//  ViewModel.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 1/3/23.
//

import Foundation

class ViewModel {
    let arrayOfElements: [Character] = ["×","÷","+","-", "*", "/", "%"]
    let arrayOfNumbers: [Character] = ["0","1","2","3","4","5","6","7","8","9"]
    lazy var arrayOfArrays: [[ModelButton]] = [stack5Array, stack4Array, stack3Array, stack2Array, stack1Array]
    
    var iconArray: [ModelButton] = [
        .init(title: "clock", backGroundColor: [], titleColor: [197.0, 154.0, 163.0], font: "", size: 0),
        .init(title: "ruler", backGroundColor: [], titleColor: [197.0, 154.0, 163.0], font: "", size: 0),
        .init(title: "function", backGroundColor: [], titleColor: [197.0, 154.0, 163.0], font: "", size: 0)
    ]
    var stack5Array: [ModelButton] = [
        .init(title: "C", backGroundColor: [24.0, 23.0, 23.0], titleColor: [240.0, 4.0, 6.0], font: "Arial", size: 27),
        .init(title: "( )", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "%", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "÷", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 37)
    ]
    var stack4Array: [ModelButton] = [
        .init(title: "7", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "8", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "9", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "×", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 37)
    ]
    var stack3Array: [ModelButton] = [
        .init(title: "4", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "5", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "6", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "–", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 37)
    ]
    var stack2Array: [ModelButton] = [
        .init(title: "1", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "2", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "3", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "+", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 37)
    ]
    var stack1Array: [ModelButton] = [
        .init(title: "+/–", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "0", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: ".", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "=", backGroundColor: [197.0, 163.0, 154.0], titleColor: [24.0, 23.0, 23.0], font: "Arial", size: 37)
    ]
}
