//
//  NUmbersLogic.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 1/2/23.
//

import Foundation

protocol NumbersDelegate {
    func didNumbersTapped(_ viewController: ViewController, which tag: Int) -> Void
}
class Print {
    lazy var viewModel = ViewModel()
    var doesContainSuffix: Bool = false
    var isLastCharacterANumber: Bool = false
    public func printElementOnDisplay(_ text: inout String?, _ element: CalElements)  {
        
        switch element {
        case .zero:
            text =  "\((text ?? "") == "0" ? "\(text ?? "")" : "\(text ?? "")0")"
        case .one:
            text = "\((text ?? "") == "0" ? "1" : "\(text ?? "")1")"
        case .two  :
            text = "\((text ?? "") == "0" ? "2" : "\(text ?? "")2")"
        case .three  :
            text = "\((text ?? "") == "0" ? "3" : "\(text ?? "")3")"
        case .four:
            text = "\((text ?? "") == "0" ? "4" : "\(text ?? "")4")"
        case .five:
            text = "\((text ?? "") == "0" ? "5" : "\(text ?? "")5")"
        case .six:
            text = "\((text ?? "") == "0" ? "6" : "\(text ?? "")6")"
        case .seven:
            text = "\((text ?? "") == "0" ? "7" : "\(text ?? "")7")"
        case .eight:
            text = "\((text ?? "") == "0" ? "8" : "\(text ?? "")8")"
        case .nine:
            text =  "\((text ?? "") == "0" ? "9" : "\(text ?? "")9")"
        case .percentage:
            text =  "\(text ?? "")%"
        case .division:
            text =  "\(text ?? "")÷"
        case .multiplication:
            text =  "\(text ?? "")×"
        case .subtraction:
            text =  "\(text ?? "")-"
        case .addition:
            text =  "\(text ?? "")+"
        case .negetive:
            if text?.isEmpty == false {
                text =  "\( -1 * (Double(text ?? "") ?? 1))"
            } else {
                text = "-"
            }
        case .decimal:
            if (text?.isEmpty ?? true) {
                text = "\(text ?? "")0."
            } else {
                if !(text?.last == ".") {
                    text = "\(text ?? "")."
                }
            }
            text = "\((text ?? "").last == "." ? "\(text ?? "")" : "\(text ?? "").")"
        case .parantheses:
            if text?.isEmpty == false {
                
                viewModel.arrayOfElements.forEach({ c in
                    if text?.hasSuffix(c) == true {
                        doesContainSuffix = true
                    }
                })
                viewModel.arrayOfNumbers.forEach({ c in
                    if text?.last! == c {
                        isLastCharacterANumber = true
                    }
                })
                if isLastCharacterANumber == true {
                    text = "\(text ?? ""))"
                } else {
                    if doesContainSuffix == true {
                        text = "\(text ?? "")("
                    }
                }
                
            } else {
                text = "\(text ?? "")("
            }
        }
    }
    
    public func printElementOnResultLabel(_ text: inout String?, _ number: CalElements)  {
        
        switch number {
        case .zero:
            text =  "\((text ?? "") == "0" ? "\(text ?? "")" : "\(text ?? "")0")"
        case .one:
            text =  "\((text ?? "") == "0" ? "1" : "\(text ?? "")1")"
        case .two  :
            text =  "\((text ?? "") == "0" ? "2" : "\(text ?? "")2")"
        case .three  :
            text =  "\((text ?? "") == "0" ? "3" : "\(text ?? "")3")"
        case .four:
            text =  "\((text ?? "") == "0" ? "4" : "\(text ?? "")4")"
        case .five:
            text =  "\((text ?? "") == "0" ? "5" : "\(text ?? "")5")"
        case .six:
            text =  "\((text ?? "") == "0" ? "6" : "\(text ?? "")6")"
        case .seven:
            text =  "\((text ?? "") == "0" ? "7" : "\(text ?? "")7")"
        case .eight:
            text =  "\((text ?? "") == "0" ? "8" : "\(text ?? "")8")"
        case .nine:
            text =  "\((text ?? "") == "0" ? "9" : "\(text ?? "")9")"
        case .parantheses:
            if text?.isEmpty == false {
                
                viewModel.arrayOfElements.forEach({ c in
                    if text?.hasSuffix(c) == true {
                        doesContainSuffix = true
                    }
                })
                viewModel.arrayOfNumbers.forEach({ c in
                    if text?.last! == c {
                        isLastCharacterANumber = true
                    }
                })
                if isLastCharacterANumber == true {
                    text = "\(text ?? ""))"
                } else {
                    if doesContainSuffix == true {
                        text = "\(text ?? "")("
                    }
                }
                
            } else {
                text = "\(text ?? "")("
            }
        case .percentage:
            text =  "\(text ?? "")%"
        case .division:
            text =  "\(text ?? "")/"
        case .multiplication:
            text =  "\(text ?? "")*"
        case .subtraction:
            text =  "\(text ?? "")-"
        case .addition:
            text =  "\(text ?? "")+"
        case .negetive:
            if text?.isEmpty == false {
                text =  "\( -1 * (Double(text ?? "") ?? 1))"
            } else {
                text = "-"
            }
        case .decimal:
            if (text?.isEmpty ?? true) {
                text = "\(text ?? "")0."
            } else {
                if !(text?.last == ".") {
                    text = "\(text ?? "")."
                }
            }
        }
    }
}