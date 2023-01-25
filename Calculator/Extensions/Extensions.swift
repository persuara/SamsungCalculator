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
    func containsParantheses() -> Bool {
        var flag: Bool = false
        let array = self.matches(for: "([\\(|\\)]+)", in: self)
        print("Array in contain Parantheses: \(array)")
        if array.count != 0 {
            flag = true
        }
        debugPrint("flagggggg ==== \(flag)")
        return flag
    }
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(start, offsetBy: min(self.count - range.lowerBound,
                                             range.upperBound - range.lowerBound))
        return String(self[start..<end])
    }
    
    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        return String(self[start...])
    }
    func arraifyMe() -> [String] {
        let inputNSString = self as NSString
        var matchArray = [NSTextCheckingResult]()
        var sectionedArray = [String]()
        let range = NSRange(location: 0, length: self.count)
        guard let sectioningRegex = try? NSRegularExpression(pattern:
                                                                "([\\d.\\d]+|[\\d]+)|([\\+\\–\\÷\\×\\%])|([\\)\\(]{1})") else { return ["wrong Jose"]}
        matchArray = sectioningRegex.matches(in: self, range: range)
        for match in matchArray {
            let matchString = inputNSString.substring(with: match.range) as String
            sectionedArray.append(matchString)
        }
        return sectionedArray
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
        MainUI.temp.removeAll(keepingCapacity: false)
        calcultaionArray.removeAll(keepingCapacity: false)
    }
    @objc func addPrintFunctionality(_ sender: UIButton) -> Void {
        animate.animateButton(sender: sender, colors: [32.0, 30.0, 30.0, 1.0])
        resultLabel.isHidden = true
        if sender.tag == 17 {
            pe.negatationRegulation(sender, on: &displayLabel.text, collection: &calcultaionArray)
            pe.negatationRegulation(sender, on: &resultLabel.text, collection: &calcultaionArray)
        } else if sender.tag == 1 { emptyAll() } else {
            pe.printTitle(sender, On: &resultLabel.text, sign: "×", collection: &calcultaionArray)
            pe.printTitle(sender, On: &displayLabel.text, sign: "×", collection: &calcultaionArray)
        }
        switch sender.tag {
        case 20:
            do {
                if isDeleteButtonTapped {
                    if let text = resultLabel.text {
                        MainUI.temp.append(text)
                    }
                    print("tapped Delete: ")
                    let end = MainUI.temp[MainUI.temp.count - 1]
                    if Double(end) == nil {
                        errorSetting.displayErrorMessage(.normal)
                    } else {
                        resultLabel.text = "\(calculator.calculate(array: &MainUI.temp).truncate(places: 5))"
                    }
                    isDeleteButtonTapped = false
                } else {
                    if let text = resultLabel.text {
                        calcultaionArray.append(text)
                    }
                    if calcultaionArray.count != 0 {
                        let end = calcultaionArray[calcultaionArray.count - 1]
                        if Double(end) == nil {
                            errorSetting.displayErrorMessage(.normal)
                        } else {
                            if leftover.sameParanthesesCount(displayLabel.text ?? "") != true {
                                print("-------same nist------")
                                var arraySame = validate.arraifyIGNORE(text: displayLabel.text ?? "")
                                resultLabel.text = "\(calculator.calculate(array: &arraySame).truncate(places: 5))"
                            } else {
                                print("-------same ee------")
                                var finalres = calculator.advancedCalculationShit(this: &displayLabel.text!)
                                resultLabel.text = "\(finalres)"
                            }
                        }
                    } else {
                        errorSetting.displayErrorMessage(.nothing)
                    }
                }
            }
        default:
            MainUI.temp = validate.arraify(text: displayLabel.text ?? "")
        }
    }
}
extension MainUI: ObjCDelegate {
    @objc func didTapDeleteButton(view: MainUI) {
        isDeleteButtonTapped = true
        var s: String?
        guard let text = displayLabel.text else {
            deleteButton.isEnabled = false
            emptyAll()
            return }
        s = text
        if s?.isEmpty == false  {
            print("Normal Delete")
            s?.removeLast()
            displayLabel.text = s
            MainUI.temp = validate.arraify(text: s!)
            print("Inside Delete Temp: \(MainUI.temp)")
            resultLabel.isHidden = true
        } else {
            displayLabel.text = nil
            deleteButton.isEnabled = false
            resultLabel.isHidden = true
        }
    }
}
extension Array {
    func stringME() -> String {
        var result = ""
        for i in 0...self.count - 1 {
            result = "\(result)\(self[i])"
        }
        return result
    }
}
