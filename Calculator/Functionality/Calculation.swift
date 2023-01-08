//
//  Calculate.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 1/8/23.
//

import Foundation
import UIKit

class Calculation {
    lazy var leftover = Leftover()
    lazy var lastElement = Validation()
    lazy var settingError = ErrorSettings()
    lazy var viewCotroller = ViewController()
    
    public func calculateResult(which label: UILabel, isTapped status: Bool, temp templabel: inout String?, substitude subResult: inout String?, labelError: ErrorMessage) -> Void {
        if status {
            if lastElement.isLastAnElement(subResult ?? "=") == true {
                //----------------------Mark: Revise Error message on "="
                settingError.showErrorMessage(labelError, which: viewCotroller.errorMessage)
            } else {
                if leftover.sameParanthesesCount(subResult ?? "") {
                    templabel = subResult ?? ""
                    if label.text != nil {
                        label.text = "\((subResult ?? "").calculate()?.truncate(places: 5) ?? 0)"
                    } else {
                        settingError.showErrorMessage(labelError, which: viewCotroller.errorMessage)
                    }
                    subResult = nil
                    label.isHidden = false
                } else {
                    let tempii = leftover.placeParatheses(subResult!)
                    subResult = "\(subResult ?? "")\(tempii)"
                    print("Placing, endResult: \(String(describing: subResult))")
                    templabel = subResult ?? ""
                    print("Temp: \(String(describing: templabel))")
                    label.text = "\(subResult!.calculate()?.truncate(places: 5) ?? 0)"
                    print("Ready to Show result: \(String(describing: label))")
                    subResult = nil
                    label.isHidden = false
                }
            }
        } else {
            if label.text != nil {
                if lastElement.isLastAnElement(label.text!) == true {
                    settingError.showErrorMessage(labelError, which: viewCotroller.errorMessage)
                    label.isHidden = true
                } else {
                    if leftover.sameParanthesesCount(label.text!) {
                        label.text = "\(label.text!.calculate()?.truncate(places: 5) ?? 0 )"
                        print("Same Para: \(String(describing: label))")
                        label.isHidden = false
                    } else {
                        let tempii = leftover.placeParatheses(label.text!)
                        label.text = "\(label.text ?? "")\(tempii)"
                        print("Diff Para \(label.text!)")
                        label.text = "\(label.text!.calculate()?.truncate(places: 5) ?? 0 )"
                        label.isHidden = false
                    }
                }
            } 
        }
    }
}
//if isDeleteButtonTapped {
//                    if isLastAnElement(ViewController.resultSubstitude ?? "=") == true {
//                        //----------------------Mark: Revise Error message on "="
//                        showErrorMessage(.normal)
//                    } else {
//                        if leftover.sameParanthesesCount(ViewController.resultSubstitude ?? "") {
//                            ViewController.temp = ViewController.resultSubstitude
//                            if resultLabel.text != nil {
//                                resultLabel.text = "\((ViewController.resultSubstitude ?? "").calculate()?.truncate(places: 5) ?? 0)"
//                            } else {
//                                showErrorMessage(.nothing)
//                            }
//                            ViewController.resultSubstitude = nil
//                            resultLabel.isHidden = false
//                        } else {
//                            let tempii = leftover.placeParatheses(ViewController.resultSubstitude!)
//                            ViewController.resultSubstitude = "\(ViewController.resultSubstitude ?? "")\(tempii)"
//                            print("Placing, endResult: \(String(describing: ViewController.resultSubstitude))")
//                            ViewController.temp = ViewController.resultSubstitude
//                            print("Temp: \(String(describing: ViewController.temp))")
//                            resultLabel.text = "\(ViewController.resultSubstitude!.calculate()?.truncate(places: 5) ?? 0)"
//                            print("Ready to Show result: \(String(describing: resultLabel.text))")
//                            ViewController.resultSubstitude = nil
//                            resultLabel.isHidden = false
//                        }
//                    }
//                } else {
//                if resultLabel.text != nil {
//                    if isLastAnElement(resultLabel.text!) == true {
//                        showErrorMessage(.normal)
//                        resultLabel.isHidden = true
//                    } else {
//                        if leftover.sameParanthesesCount(resultLabel.text!) {
//                            resultLabel.text = "\(resultLabel.text!.calculate()?.truncate(places: 5) ?? 0 )"
//                            print("Same Para: \(String(describing: resultLabel.text))")
//                            resultLabel.isHidden = false
//                        } else {
//                            let tempii = leftover.placeParatheses(resultLabel.text!)
//                            resultLabel.text = "\(resultLabel.text ?? "")\(tempii)"
//                            print("Diff Para \(String(describing: resultLabel.text))")
//                            resultLabel.text = "\(resultLabel.text!.calculate()?.truncate(places: 5) ?? 0 )"
//                            resultLabel.isHidden = false
//                        }
//                    }
//                } else {
//                    print("Nothing to compute!")
//                }
//            }
