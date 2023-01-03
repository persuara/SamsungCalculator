//
//  ViewModel.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 1/3/23.
//

import Foundation

class ViewModel {
    var iconArray: [ModelButton] = [
        .init(title: "clock", backGroundColor: [], titleColor: [197.0, 154.0, 163.0], font: "", size: 0),
        .init(title: "ruler", backGroundColor: [], titleColor: [197.0, 154.0, 163.0], font: "", size: 0),
        .init(title: "function", backGroundColor: [], titleColor: [197.0, 154.0, 163.0], font: "", size: 0)
    ]
    var stack5Array: [ModelButton] = [
        .init(title: "Alt", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "Rad", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "√", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "C", backGroundColor: [24.0, 23.0, 23.0], titleColor: [240.0, 4.0, 6.0], font: "Arial", size: 27),
        .init(title: "( )", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "%", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "÷", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 37)
    ]
    var stack4Array: [ModelButton] = [
        .init(title: "sin", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "cos", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "tan", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "7", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "8", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "9", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "×", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 37)
    ]
    var stack3Array: [ModelButton] = [
        .init(title: "In", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "log", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "1/x", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
    
        .init(title: "4", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "5", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "6", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "–", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 37)
    ]
    var stack2Array: [ModelButton] = [
        .init(title: "eª", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "x2ª", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "xª", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "1", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "2", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "3", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "+", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 37)
    ]
    var stack1Array: [ModelButton] = [
        .init(title: "|x|", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "π", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "e", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "+/–", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "0", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: ".", backGroundColor: [24.0, 23.0, 23.0], titleColor: [197.0, 163.0, 154.0], font: "Arial", size: 27),
        .init(title: "=", backGroundColor: [197.0, 163.0, 154.0], titleColor: [24.0, 23.0, 23.0], font: "Arial", size: 37)
    ]
}
