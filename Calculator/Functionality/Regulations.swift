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
    var calculationArray = [String]()
    static var count = 0
    
    var label = UILabel()
    var resLabel = UILabel()
    var temp: String?
    
    var flag : Bool = false
    var decimalFlag = false
    var doesContainSuffix: Bool = false
    var isLastCharacterANumber: Bool = false
    var doesContainPercentage: Bool = false
    public func printTitle(_ sender: UIButton, On text: inout String?, sign: String, collection: inout [String] ) -> Void {
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
                decimalRegulation(sender, on: &text)
            } else if sender.tag == 2 {
                paranthesesRegulation(on: &text, sign: sign, collection: &collection)
            } else if sender.tag == 3 {
                
                text = "\(text ?? "")%×"
                
            } else if sender.tag == 4 || sender.tag == 8 || sender.tag == 12 || sender.tag == 16 {
                MainUI.enteredElementsArray.append("\(sender.titleLabel!.text!)")
                if text == resLabel.text {
                    resLabel.text = nil
                    text = "\(sender.titleLabel!.text!)"
                    collection.append(text!)
                    resLabel.text = nil
                } else {
                    text = "\(text ?? "")\(sender.titleLabel!.text!)"
                    resLabel.text = nil
                }
            } else if sender.tag == 20 {
                resLabel.isHidden = false
            } else {
                text = "\(text ?? "")\(sender.titleLabel!.text!)"
            }
        }
    }
    private func paranthesesRegulation(on text: inout String?, sign: String, collection: inout [String]) {
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
            if text?.count == 1 {
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
                print("πππ    With Element, Number      πππ")
                text = "×\(sender.titleLabel!.text!)"
            } else {
                print("NORMAL Number")
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
//        var flaggagaga = false
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
    // MARK ----------------
    public func negatationRegulation(_ sender: UIButton, on text: inout String?) {
        
        if text == nil {
            text = "(-"
        } else {
            validation.negetateAndReplaceLastNum(&text!)
        }
        Regulations.count += 1
    }
    private func placeMinusSign(text: inout String) {
        //        var arraified = text.arraifyMe()
        
    }
    // ----------------------END MARK ----------------
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
        if flag {
            text = text?.replacingOccurrences(of: "\(text!.last!)", with: "\(sender.titleLabel!.text!)")
            flag = !flag
        } else {
            if sender.tag == 3 {
                text = "\(text ?? "")%×"
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
    }
}
