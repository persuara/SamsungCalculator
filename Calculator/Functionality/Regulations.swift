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
    var label = UILabel()
    var resLabel = UILabel()
    var flag : Bool = false
    var decimalFlag = false
    var doesContainSuffix: Bool = false
    var isLastCharacterANumber: Bool = false
    var doesContainPercentage: Bool = false
    public func printTitle(_ sender: UIButton, On text: inout String?) -> Void {
        guard text == text else { return }
        var lastElFlag: Bool = false
        let array = [5, 6, 7, 9, 10, 11, 13, 14, 15, 18]
        array.forEach({ numbersTag in
            if sender.tag == numbersTag {
                flag = true
            }
        })
        viewModel.arrayOfElements.forEach({ c in
            if text?.last == c {
                lastElFlag = true
            }
        })
        if flag == true {
            numbersRegulation(sender, on: &text)
            flag = !flag
        } else {
            if sender.tag == 19 {
                decimalRegulation(sender, on: &text)
            } else if sender.tag == 2 {
                paranthesesRegulation(on: &text)
            } else if sender.tag == 3 {
                if lastElFlag {
                    text?.removeLast()
                    text = "\(text ?? "")%×"
                    lastElFlag = !lastElFlag
                } else {
                    text = "\(text ?? "")%×"
                }
            } else if sender.tag == 12 {
                if lastElFlag {
                    text?.removeLast()
                    if text?.last == "(" {
                        text = "\(text ?? "")-"
                    } else {
                        text = "\(text ?? "")\(sender.titleLabel!.text!)"
                    }
                    lastElFlag = !lastElFlag
                } else {
                    if text?.last == "(" {
                        text = "\(text ?? "")-"
                    } else {
                        text = "\(text ?? "")\(sender.titleLabel!.text!)"
                    }
                }
            }
            else if sender.tag == 4 || sender.tag == 8 || sender.tag == 16 {
                if lastElFlag {
                    text?.removeLast()
                    text = "\(text ?? "")\(sender.titleLabel!.text!)"
                    lastElFlag = !lastElFlag
                } else {
                    text = "\(text ?? "")\(sender.titleLabel!.text!)"
                }
            } else if sender.tag == 20 {
                resLabel.isHidden = false
            } else {
                text = "\(text ?? "")\(sender.titleLabel!.text!)"
            }
        }
    }
    private func paranthesesRegulation(on text: inout String?) {
        if text == nil {
            text = "\(text ?? "")("
        } else {
            viewModel.arrayOfElements.forEach({ c in
                if text?.last == c {
                    doesContainSuffix = true
                }
            })
            viewModel.arrayOfNumbers.forEach({ c in
                if text?.last == c {
                    isLastCharacterANumber = true
                }
            })
            if text?.last == "(" {
                text = "\(text ?? "")("
            } else if text?.count == 1 {
                text = "\(text ?? "")×("
            } else if doesContainSuffix == true {
                text = "\(text ?? "")("
                doesContainSuffix = !doesContainSuffix
            } else if isLastCharacterANumber == true {
                text = "\(text ?? ""))"
                isLastCharacterANumber = !isLastCharacterANumber
            }
        }
    }
    public func numbersRegulation(_ sender: UIButton, on text: inout String?) {
        if text == nil {
            if MainUI.enteredElementsArray.isEmpty == false {
                text = "×\(sender.titleLabel!.text!)"
            } else {
                text = "\(sender.titleLabel!.text!)"
            }
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
                text = "\(text ?? "")."
        }
    }
    public func negatationRegulation(_ sender: UIButton, on text: inout String?) {
        if text == nil {
            text = "(-"
        } else {
            validation.negetateAndReplaceLastNum(&text!)
        }
    }
}
