//
//  Extensions.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 1/3/23.
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
        if array.count != 0 {
            flag = true
        }
        return flag
    }
    func arraifyMe() -> [String] {
        let inputNSString = self as NSString
        var matchArray = [NSTextCheckingResult]()
        var sectionedArray = [String]()
        let range = NSRange(location: 0, length: self.count)
        guard let sectioningRegex = try? NSRegularExpression(pattern:
                                                                "([-?\\d.\\d]+|[-?\\d]+)|([\\+\\–\\÷\\×\\%])|([\\)\\(]{1})") else { return ["wrong Jose"]}
        matchArray = sectioningRegex.matches(in: self, range: range)
        for match in matchArray {
            let matchString = inputNSString.substring(with: match.range) as String
            sectionedArray.append(matchString)
        }
        return sectionedArray
    }
    public mutating func addNumberFormatter(style: NumberFormatter.Style = .decimal) -> String {
        let fmt = NumberFormatter()
        fmt.numberStyle = style
        let arrayWorkedOn = self.arraifyMe()
        for i in 0...arrayWorkedOn.count - 1 {
            if Double(arrayWorkedOn[i]) != nil {
                let changed = fmt.string(from: Double(arrayWorkedOn[i])! as NSNumber)
                self = replacingOccurrences(of: arrayWorkedOn[i], with: changed!)
            }
        }
        return self
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
        MainUI.enteredElementsArray.removeAll()
    }
    @objc func addPrintFunctionality(_ sender: UIButton) -> Void {
        animate.animateButton(sender: sender, colors: [32.0, 30.0, 30.0, 1.0])
//        displayLabel.text?.addNumberFormatter()
        resultLabel.isHidden = true
        if sender.tag == 17 {
            pe.negatationRegulation(sender, on: &displayLabel.text)
            pe.negatationRegulation(sender, on: &resultLabel.text)
        } else if sender.tag == 1 { emptyAll() } else {
            if sender.tag == 3 || sender.tag == 4 || sender.tag == 3 || sender.tag == 8 || sender.tag == 12 || sender.tag == 16 {
                if displayLabel.text == nil {
                    errorSetting.displayErrorMessage(.normal)
                    resultLabel.isHidden = true
                } else {
                    pe.printTitle(sender, On: &resultLabel.text, sign: "×", collection: &calcultaionArray)
                    pe.printTitle(sender, On: &displayLabel.text, sign: "×", collection: &calcultaionArray)
                }
            } else {
                pe.printTitle(sender, On: &resultLabel.text, sign: "×", collection: &calcultaionArray)
                pe.printTitle(sender, On: &displayLabel.text, sign: "×", collection: &calcultaionArray)
            }
        }
        switch sender.tag {
        case 20:
            do {
                if isDeleteButtonTapped {
                    viewModel.arrayOfElements.forEach({ [weak self] c in
                        guard self != nil else {return}
                        if MainUI.temp?.last == c {
                            isLastCharElement = true
                        }
                    })
                    if isLastCharElement {
                        errorSetting.displayErrorMessage(.normal)
                        isLastCharElement = !isLastCharElement
                        resultLabel.isHidden = true
                    } else {
                        displayLabel.text = MainUI.temp
                        if leftover.sameParanthesesCount(displayLabel.text ?? "") != true {
                            if leftover.diffInParanthesesCount(displayLabel.text ?? "") > 0 {
                                let helper = leftover.placeParatheses(displayLabel.text ?? "")
                                displayLabel.text = "\(displayLabel.text ?? "")\(helper)"
                                let finalres = calculator.advancedCalculationShit(this: displayLabel.text!)
                                resultLabel.text = finalres
                                resultLabel.isHidden = false
                            } else {
                                let helper = leftover.placeParatheses(displayLabel.text ?? "")
                                displayLabel.text = "\(helper)\(displayLabel.text ?? "")"
                                let finalres = calculator.advancedCalculationShit(this: displayLabel.text!)
                                resultLabel.text = finalres
                                resultLabel.isHidden = false
                            }
                        } else {
                            let finalres = calculator.advancedCalculationShit(this: displayLabel.text!)
                            resultLabel.text = finalres
                        }
                    }
                    isDeleteButtonTapped = !isDeleteButtonTapped
                } else {
                    if displayLabel.text != nil {
                        viewModel.arrayOfElements.forEach({ [weak self] c in
                            guard self != nil else {return}
                            if displayLabel.text?.last == c {
                                isLastCharElement = true
                            }
                        })
                        if isLastCharElement {
                            errorSetting.displayErrorMessage(.normal)
                            isLastCharElement = !isLastCharElement
                            resultLabel.isHidden = true
                        } else {
                            if leftover.sameParanthesesCount(displayLabel.text ?? "") != true {
                                let helper = leftover.placeParatheses(displayLabel.text ?? "")
                                if leftover.diffInParanthesesCount(displayLabel.text ?? "") > 0 {
                                    displayLabel.text = "\(displayLabel.text ?? "")\(helper)"
                                } else {
                                    displayLabel.text = "\(helper)\(displayLabel.text ?? "")"
                                }
                                let finalres = calculator.advancedCalculationShit(this: (displayLabel.text)!)
                                resultLabel.text = "\(finalres)"
                            } else {
                                let finalres = calculator.advancedCalculationShit(this: displayLabel.text!)
                                resultLabel.text = "\(finalres)"
                            }
                        }
                    } else {
                        errorSetting.displayErrorMessage(.nothing)
                    }
                }
            }
        default:
            MainUI.temp = displayLabel.text ?? ""
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
            s?.removeLast()
            displayLabel.text = s
            MainUI.temp = s ?? ""
            resultLabel.isHidden = true
        } else {
            displayLabel.text = nil
            deleteButton.isEnabled = false
            resultLabel.isHidden = true
        }
    }
}
extension Array where Element : Equatable {
    func stringME() -> String {
        var result = ""
        for i in 0...self.count - 1 {
            result = "\(result)\(self[i])"
        }
        return result
    }
    public subscript(safe bounds: Range<Int>) -> ArraySlice<Element> {
        if bounds.lowerBound > count { return [] }
        let lower = Swift.max(0, bounds.lowerBound)
        let upper = Swift.max(0, Swift.min(count, bounds.upperBound))
        return self[lower..<upper]
    }
    
    public subscript(safe lower: Int?, _ upper: Int?) -> ArraySlice<Element> {
        let lower = lower ?? 0
        let upper = upper ?? count
        if lower > upper { return [] }
        return self[safe: lower..<upper]
    }
}
