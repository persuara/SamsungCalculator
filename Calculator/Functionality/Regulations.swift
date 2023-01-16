//
//  NUmbersLogic.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 1/2/23.
//

import Foundation
import UIKit

class Regulations {
    
    lazy var viewModel = ViewModel()
    lazy var validation = Validation()
    lazy var leftOver = Leftover()
    lazy var ui = MainUI()
    lazy var errorSetting = ErrorSettings()
    var label = UILabel()
    var resLabel = UILabel()
    var temp: String?
    
    var flag : Bool = false
    var decimalFlag = false
    var doesContainSuffix: Bool = false
    var isLastCharacterANumber: Bool = false
    var doesContainPercentage: Bool = false
    
    public func printTitle(_ sender: UIButton, On text: inout String?, sign: String) -> Void {
        guard text == text else { return }
        let array = [5, 6, 7, 9, 10, 11, 13, 14, 15, 18]
        array.forEach({ numbersTag in
            if sender.tag == numbersTag {
                flag = true
            }
        })
        if flag == true {
            numbersRegulation(sender, on: &text)
            flag = !flag
        } else {
            if sender.tag == 19 {
                print("currently handling decimal Reg")
                decimalRegulation(sender, on: &label.text)
                decimalRegulation(sender, on: &resLabel.text)
                decimalRegulation(sender, on: &temp)
            } else if sender.tag == 2 {
                paranthesesRegulation(on: &text, sign: sign)
            } else if sender.tag == 3 || sender.tag == 4 || sender.tag == 8 || sender.tag == 12 || sender.tag == 16  {
                errorSetting.displayErrorMessage(.normal, from: label.text)
                if label.text != nil {
                    arithmicExpressionRegulation(on: &label.text, sender: sender)
                    arithmicExpressionRegulation(on: &resLabel.text, sender: sender)
                    arithmicExpressionRegulation(on: &temp, sender: sender)
                }
            } else {
                if sender.tag == 20 {
//                    print("tapped on =")
                } else {
                    text = "\(text ?? "")\(sender.titleLabel!.text!)"
                }
            }
        }
    }
    private func paranthesesRegulation(on text: inout String?, sign: String) {
        if text == nil {
            text = "\(text ?? "")("
        } else {
            viewModel.arrayOfElements.forEach({ [weak self] c in
                guard (self != nil) else { return }
                if text?.last! == c {
                    doesContainSuffix = true
                }
            })
            if doesContainSuffix {
                text = "\(text ?? "")("
                doesContainSuffix = !doesContainSuffix
            } else if validation.isOnlyOneNumber(text!) {
                validation.placeArithmicElementifOnlyOneNumber(&text!, which: sign)
            } else {
                validation.placeArithmicElementifOnlyOneNumber(&text!, which: sign)
                viewModel.arrayOfElements.forEach({ [weak self] c in
                    guard (self != nil) else { return }
                    if text?.last! == c {
                        doesContainSuffix = true
                    }
                })
                viewModel.arrayOfNumbers.forEach({ [weak self] c in
                    guard (self != nil) else { return }
                    if text?.last! == c {
                        isLastCharacterANumber = true
                    }
                })
                if isLastCharacterANumber == true {
                    text = "\(text ?? ""))"
                    isLastCharacterANumber = !isLastCharacterANumber
                } else {
                    if doesContainSuffix == true {
                        text = "\(text ?? "")("
                        doesContainSuffix = !doesContainSuffix
                    }
                }
            }
        }
    }
    public func numbersRegulation(_ sender: UIButton, on text: inout String?) {
        if text == nil {
            text = "\(sender.titleLabel!.text!)"
        } else {
            if (text ?? "") == "0" {
                text = "\(sender.titleLabel!.text!)"
            } else {
                text = "\(text!)\(sender.titleLabel!.text!)"
            }
        }
    }
    public func decimalRegulation(_ sender: UIButton, on text: inout String?) {
        if text != nil {
            viewModel.arrayOfNumbers.forEach({ c in
                if text?.last == c {
                    decimalFlag = true
                }
            })
        }
        if text == nil {
            text = "\(text ?? "")0."
        } else {
            if decimalFlag == true {
                text = "\(text!)."
                decimalFlag = !decimalFlag
            } else {
                if !(text?.last == ".") {
                }
            }
        }
    }
    public func negatationRegulation(_ sender: UIButton, on text: inout String?) {
        if text != nil {
            print("text is not nil so ")
            validation.negetateAndReplaceLastNum(&text!)
        } else {
            text = "-"
        }
    }
    public func goThroughArray(array: [Character], text: String?) -> Bool {
        var flag: Bool = false
        array.forEach({ c in
            if (text ?? "").last! == c {
                flag = true
            }
        })
        return flag
    }
    public func arithmicExpressionRegulation(on text: inout String?, sender: UIButton) -> Void {
        var flag: Bool = false
        viewModel.arrayOfElements.forEach({ c in
            if text?.last  == c {
                flag = true
            }
        })
        if text == label.text {
            if flag {
                text = text?.replacingOccurrences(of: "\(text!.last!)", with: "\(sender.titleLabel!.text!)")
                flag = !flag
            } else {
                if sender.tag == 3 {
                    text = "\(text ?? "")%"
                } else  if sender.tag == 4 {
                    text = "\(text ?? "")÷"
                } else if sender.tag == 8 {
                    text = "\(text ?? "")×"
                } else if sender.tag == 12 {
                    text = "\(text ?? "")–"
                } else if sender.tag == 16 {
                    text = "\(text ?? "")+"
                }
            }
        } else {
            if flag {
                if sender.tag == 4 {
                    text = text?.replacingOccurrences(of: "\(text!.last!)", with: "/")
                } else if sender.tag == 8 {
                    text = text?.replacingOccurrences(of: "\(text!.last!)", with: "*")
                } else if sender.tag == 12 {
                    text = text?.replacingOccurrences(of: "\(text!.last!)", with: "-")
                } else if sender.tag == 16 {
                    text = text?.replacingOccurrences(of: "\(text!.last!)", with: "+")
                } else if sender.tag == 3 {
                }
                flag = !flag
            } else {
                if sender.tag == 3 {
                    text = "\(text ?? "")/100*"
                } else if sender.tag == 4 {
                    text = "\(text ?? "")/"
                } else if sender.tag == 8 {
                    text = "\(text ?? "")*"
                } else if sender.tag == 12 {
                    text = "\(text ?? "")-"
                } else if sender.tag == 16 {
                    text = "\(text ?? "")+"
                }
            }
        }
    }
}
