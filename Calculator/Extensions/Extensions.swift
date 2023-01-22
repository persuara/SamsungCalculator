//
//  Extensions.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 1/3/23.
//

import Foundation
import UIKit
extension UIView {
    public func constraintTopBottomToSuperview(view: UIView,both: Bool = true, onlyTop: Bool = false ,topConstant: CGFloat = 0.0,
                                               bottomConstant: CGFloat = 0.0) {
        if both == true {
            topAnchor.constraint(equalTo: view.topAnchor, constant: topConstant).isActive = true
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomConstant).isActive = true
        } else if onlyTop {
            topAnchor.constraint(equalTo: view.topAnchor, constant: topConstant).isActive = true
        } else {
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomConstant).isActive = true
        }
    }
    public func setConstraints(both: Bool = true, onlyTrail: Bool = false,isHeightWidthNeeded: Bool, leadingConstant: CGFloat = 0.0,
                               trailingConstant: CGFloat = 0.0, widthConst: CGFloat = 0.0, heightConstant: CGFloat =  0.0) {
        guard let superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        if isHeightWidthNeeded == true {
            widthAnchor.constraint(equalToConstant: widthConst).isActive = true
            heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
        } else {
            if both {
                leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leadingConstant).isActive = true
                trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: trailingConstant).isActive = true
            } else if onlyTrail {
                trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: trailingConstant).isActive = true
            } else {
                leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leadingConstant).isActive = true
            }
        }
    }
}

extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
    func truncate(places: Int) -> Double {
        return Double(floor(pow(10.0, Double(places)) * Double(self)) / pow(10.0, Double(places)))
    }
    
}

extension String {
    private func allNumsToDouble() -> String {
        
        let symbolsCharSet = ".,()"
        let fullCharSet = "0123456789" + symbolsCharSet
        var i = 0
        var result = ""
        let chars = Array(self)
        while i < chars.count {
            if fullCharSet.contains(chars[i]) {
                var numString = String(chars[i])
                i += 1
            loop: while i < chars.count {
                if fullCharSet.contains(chars[i]) {
                    numString += String(chars[i])
                    i += 1
                } else {
                    break loop
                }
            }
                if let num = Double(numString) {
                    result += "\(num)"
                } else {
                    result += numString
                }
            } else {
                result += String(chars[i])
                i += 1
            }
        }
        return result
    }
    func calculate() -> Double {
        let transformed = allNumsToDouble()
        let expr = NSExpression(format: transformed)
        return expr.expressionValue(with: nil, context: nil) as! Double
        }
        func matches(for regex: String, in text: String) -> [String] {
            
            do {
                let regex = try NSRegularExpression(pattern: regex)
                let results = regex.matches(in: text,
                                            range: NSRange(text.startIndex..., in: text))
                return results.map {
                    String(text[Range($0.range, in: text)!])
                }
            } catch let error {
                print("invalid regex: \(error.localizedDescription)")
                return []
            }
        }
        
    }
extension MainUI {
    func addButton(_ number: Int, from array: [ModelButton], which stack: UIStackView) -> Void {
        for i in 0...number {
            numbersTag += 1
            let btn: UIButton = .init(frame: .zero)
            btn.tag = numbersTag
            btn.heightAnchor.constraint(equalToConstant: 80).isActive = true
            btn.setTitle(array[i].title, for: .normal)
            btn.layer.cornerRadius = 40
            btn.setTitleColor(UIColor(cgColor: CGColor(red: array[i].titleColor[0]/255.0, green: array[i].titleColor[1]/255.0, blue: array[i].titleColor[2]/255.0, alpha: 1.0)), for: .normal)
            btn.backgroundColor = UIColor(cgColor: CGColor(red: array[i].backGroundColor[0]/255.0, green: array[i].backGroundColor[1]/255.0, blue: array[i].backGroundColor[2]/255.0, alpha: 1.0))
            btn.titleLabel?.font = UIFont.init(name: array[i].font, size: CGFloat(array[i].size))
            btn.addTarget(self, action: #selector(addPrintFunctionality), for: .touchUpInside)
            stack.addArrangedSubview(btn)
        }
    }
    func emptyAll() {
        displayLabel.text = nil
        resultLabel.text = nil
        MainUI.temp = nil
    }
    @objc func addPrintFunctionality(_ sender: UIButton) -> Void {
        animate.animateButton(sender: sender, colors: [32.0, 30.0, 30.0, 1.0])
        resultLabel.isHidden = true
        if sender.tag == 17 {
            print("computing sender.tag -- 17")
            pe.negatationRegulation(sender, on: &displayLabel.text)
            pe.negatationRegulation(sender, on: &resultLabel.text)
        } else if sender.tag == 1 { emptyAll() } else {
            pe.printTitle(sender, On: &displayLabel.text, sign: "×")
            pe.printTitle(sender, On: &resultLabel.text, sign: "*")
        }
        switch sender.tag {
        case 20:
            if isDeleteButtonTapped == true {
                if validate.isLastAnElement(MainUI.temp ?? "=") == true {
                    errorSetting.displayErrorMessage(.normal, from: displayLabel.text)
                } else {
                    if leftover.sameParanthesesCount(resultLabel.text ?? "") == true {
                        if validate.validToParse(resultLabel.text ?? "") == true {
                            resultLabel.text = "\(resultLabel.text!.calculate().truncate(places: 5))"
                            resultLabel.isHidden = false
                        } else {
                            resultLabel.isHidden = true
                        }
                        
                    } else {
                        let tempii = leftover.placeParatheses(MainUI.temp!)
                        resultLabel.text = "\(resultLabel.text ?? "")\(tempii)"
                        if validate.validToParse(resultLabel.text!) {
                            resultLabel.text = "\(resultLabel.text!.calculate().truncate(places: 5))"
                            resultLabel.isHidden = false
                        } else {
                            resultLabel.isHidden = true
                        }
                    }
                }
                isDeleteButtonTapped = !isDeleteButtonTapped
            } else {
                print("Stage: NormalCalculation")
                if resultLabel.text != nil {
                    if validate.isLastAnElement(resultLabel.text!) == true {
                        errorSetting.displayErrorMessage(.normal, from: displayLabel.text)
                        resultLabel.isHidden = true
                    } else {
                        if leftover.sameParanthesesCount(resultLabel.text!) {
                            if validate.validToParse(resultLabel.text!) == true {
                                print("valid to parse")
                                print(resultLabel.text as Any)
                                resultLabel.text = "\(resultLabel.text!.calculate().truncate(places: 5))"
                                resultLabel.isHidden = false
                            } else {
                                print("Invalid to parse")
                                errorSetting.displayErrorMessage(.error, from: resultLabel.text)
                                resultLabel.isHidden = true
                            }
                        } else {
                            isExtraParanthesesNeeded = true
                            if leftover.diffInParanthesesCount(resultLabel.text!) > 0 {
                                let tempii = leftover.placeParatheses(resultLabel.text!)
                                resultLabel.text = "\(resultLabel.text ?? "")\(tempii)"
                            } else {
                                let tempii = leftover.placeParatheses(resultLabel.text!)
                                resultLabel.text = "\(tempii)\(resultLabel.text ?? "")"
                            }
                            if validate.validToParse(resultLabel.text!) == true {
                                resultLabel.text = "\(resultLabel.text!.calculate().truncate(places: 5))"
                                resultLabel.isHidden = false
                            } else {
                                errorSetting.displayErrorMessage(.error, from: resultLabel.text)
                                resultLabel.isHidden = true
                            }
                        }
                    }
                } else {
                    errorSetting.displayErrorMessage(.nothing, from: displayLabel.text)
                }
            }
        default:
            MainUI.temp = resultLabel.text ?? ""
        }
    }
}
extension MainUI: ObjCDelegate {
    @objc func didTapDeleteButton(view: MainUI) {
        isDeleteButtonTapped = true
        var s: String?
        var r: String?
        guard let text = displayLabel.text else {
            deleteButton.isEnabled = false
            emptyAll()
            return }
        s = text
        r = MainUI.temp
        if s?.isEmpty == false && r?.isEmpty == false {
            let absDiff = abs(leftover.diffInParanthesesCount(r!))
            if isExtraParanthesesNeeded {
                print("--------------Extra delete needed!-------------")
                for _ in 0...absDiff{
                    r?.removeLast()
                }
                if s?.last == "%" {
                    for _ in 1...4 {
                        r?.removeLast()
                    }
                }
                isExtraParanthesesNeeded = !isExtraParanthesesNeeded
                resultLabel.isHidden = true
            } else {
                print("Normal Delete")
                s?.removeLast()
                r?.removeLast()
                displayLabel.text = s
                MainUI.temp = r
//                       MainUI.resultSubstitude = r
                resultLabel.text = MainUI.temp
//                  print("Inside Delete Button: ResultSubstitude =  \(MainUI.resultSubstitude ?? "")")
                resultLabel.isHidden = true
            }
        } else {
            displayLabel.text = nil
            deleteButton.isEnabled = false
            resultLabel.isHidden = true
        }
    }
    @objc func didTapPrint(view: MainUI, sender: UIButton) {
       
    }
}
    
