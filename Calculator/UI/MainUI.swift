//
//  MainUI.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 1/3/23.
//

import UIKit

class MainUI: UIView {
    
    var numbersTag: Int = 0
    
    lazy var viewModel = ViewModel()
    lazy var config = ConfigUi()
    lazy var animate = Animation()
    lazy var pe = Print()
    lazy var errorSetting = ErrorSettings()
    lazy var lastElement = Validation()
    lazy var leftover = Leftover()
    
    var isDeleteButtonTapped: Bool = false
    var isLastCharElement: Bool = false
    var isExtraParanthesesNeeded: Bool = false
    
    private lazy var cstacksArray: [UIStackView] = [
        rowFiveStackView, rowFourStackView, rowThreeStackView, rowTwoStackView, rowOneStackView
    ]
    private lazy var mainStackView = config.stackView(spacing: 10, axis: .vertical)
    public lazy var displayLabel = config.label()
    public lazy var resultLabel = config.label(numberOfLines: 1, isHidden: false, alpha: 0.7, size: 25)
    private lazy var rowOneStackView = config.stackView()
    private lazy var rowTwoStackView = config.stackView()
    private lazy var rowThreeStackView = config.stackView()
    private lazy var rowFourStackView = config.stackView()
    private lazy var rowFiveStackView = config.stackView()
    public lazy var deleteButton = config.button()
    private lazy var errorMessage = config.label(numberOfLines: 1, isHidden: false, backgroundColor: .gray.withAlphaComponent(0.7), size: 27)
    
    private lazy var hairline: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 40.0/255.0, green: 40.0/255.0, blue: 40.0/255.0, alpha: 1.0)
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        pe.label = displayLabel
        
        addSubview(mainStackView)
        mainStackView.constraintLeadingTrainlingToSuperview()
        
        addSubview(displayLabel)
        displayLabel.constraintLeadingTrainlingToSuperview(leadingConstant: 15, trailingConstant: -20)
        
        addSubview(hairline)
        hairline.constraintLeadingTrainlingToSuperview()
        
        addSubview(deleteButton)

        addSubview(resultLabel)
        resultLabel.constraintLeadingTrainlingToSuperview(leadingConstant: 20, trailingConstant: -30)
        
        addSubview(errorMessage)
        errorSetting.label = errorMessage
        
        cstacksArray.enumerated().forEach { [weak self] element in
            guard let self else { return }
            element.element.backgroundColor = .black
            self.mainStackView.addArrangedSubview(element.element)
        }
        for i in 0...cstacksArray.count - 1 {
            addButton(3, from: viewModel.arrayOfArrays[i], which: cstacksArray[i])
        }
        
        let constraints: [NSLayoutConstraint] = [
            displayLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            displayLabel.heightAnchor.constraint(equalToConstant: 130),
            hairline.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 50),
            hairline.heightAnchor.constraint(equalToConstant: 2),
            
            deleteButton.bottomAnchor.constraint(equalTo: hairline.topAnchor, constant: -30),
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            deleteButton.heightAnchor.constraint(equalToConstant: 18),
            deleteButton.widthAnchor.constraint(equalToConstant: 23),
            
            mainStackView.topAnchor.constraint(equalTo: hairline.topAnchor, constant: 20),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            resultLabel.bottomAnchor.constraint(equalTo: deleteButton.topAnchor, constant: -25),
            resultLabel.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
     func hideResultLabel() {
         resultLabel.isHidden = true
     }
    private func emptyAll() {
        displayLabel.text = nil
        resultLabel.text = nil
        ViewController.temp = nil
    }
     
     @objc func addPrintFunctionality(_ sender: UIButton) -> Void {
         animate.animateButton(sender: sender, colors: [32.0, 30.0, 30.0, 1.0])
         if sender.tag == 19 {
             pe.decimalRegulation(sender, on: &displayLabel.text)
             pe.decimalRegulation(sender, on: &resultLabel.text)
             pe.decimalRegulation(sender, on: &ViewController.temp)
         } else if sender.tag == 17 {
             pe.negatationRegulation(sender, on: &displayLabel.text)
             pe.negatationRegulation(sender, on: &resultLabel.text)
             pe.negatationRegulation(sender, on: &ViewController.temp)
         }
         else {
             if sender.tag == 3 || sender.tag == 4 || sender.tag == 8 || sender.tag == 12 || sender.tag == 16  {
                 if displayLabel.text != nil {
                     pe.arithmicExpressionRegulation(on: &displayLabel.text, sender: sender)
                     pe.arithmicExpressionRegulation(on: &resultLabel.text, sender: sender)
                     pe.arithmicExpressionRegulation(on: &ViewController.temp, sender: sender)
                 } else {
                     print("An error message will pop up here :]")
                 }
             } else {
                 pe.printTitle(sender, On: &displayLabel.text, sign: "×")
                 pe.printTitle(sender, On: &resultLabel.text, sign: "*")
                 pe.printTitle(sender, On: &ViewController.temp, sign: "*")
             }
         }
         
         for _ in 0...sender.tag {
//             hideResultLabel()
             resultLabel.isHidden = false
             if sender.tag == 35 {
                 resultLabel.isHidden = false
             }
         }
         switch sender.tag {
         case 1:
             emptyAll()
         case 3:
             if displayLabel.text == nil {
//                 displayErrorMessage(.normal, from: displayLabel.text)
             } else {
                 if (displayLabel.text?.last)! == "%"  {
//                     displayErrorMessage(.normal, from: displayLabel.text)
                 } else if  lastElement.isLastAnElement(displayLabel.text!) == true {
//                     displayErrorMessage(.normal, from: displayLabel.text)
                 } else {
//                     pe.actuallyPrint(isTapped: isDeleteButtonTapped,
//                                      display: &displayLabel,
//                                      result: &resultLabel,
//                                      substitudeLabel: &ViewController.resultSubstitude,
//                                      element: .percentage)
                 }
             }
         case 4:
             if displayLabel.text == nil {
//                 showErrorMessage(.normal)
             } else {
                 if (displayLabel.text?.last)! == "÷"  {
//                     displayErrorMessage(.normal, from: displayLabel.text)
                 } else if lastElement.isLastAnElement(displayLabel.text!) == true {
//                     displayErrorMessage(.normal, from: displayLabel.text)
                 } else {
//                     pe.actuallyPrint(isTapped: isDeleteButtonTapped,
//                                      display: &displayLabel,
//                                      result: &resultLabel,
//                                      substitudeLabel: &ViewController.resultSubstitude,
//                                      element: .division)
                 }
             }
         case 8:
             if displayLabel.text == nil {
//                 showErrorMessage(.normal)
             } else {
                 if (displayLabel.text?.last)! == "×"  {
//                     displayErrorMessage(.normal, from: displayLabel.text)
                 } else if  lastElement.isLastAnElement(displayLabel.text!) == true {
//                     displayErrorMessage(.normal, from: displayLabel.text)
                 } else {
//                     pe.actuallyPrint(isTapped: isDeleteButtonTapped,
//                                      display: &displayLabel,
//                                      result: &resultLabel,
//                                      substitudeLabel: &ViewController.resultSubstitude,
//                                      element: .multiplication)
                 }
             }
         case 12:
             if displayLabel.text == nil {
//                 showErrorMessage(.normal)
             } else {
                 if (displayLabel.text?.last)! == "-"  {
//                     displayErrorMessage(.normal, from: displayLabel.text)
                 } else if  lastElement.isLastAnElement(displayLabel.text!) == true {
//                     displayErrorMessage(.normal, from: displayLabel.text)
                 } else {
//                     pe.actuallyPrint(isTapped: isDeleteButtonTapped,
//                                      display: &displayLabel,
//                                      result: &resultLabel,
//                                      substitudeLabel: &ViewController.resultSubstitude,
//                                      element: .subtraction)
                 }
             }
         case 16:
             if displayLabel.text == nil {
//                 showErrorMessage(.normal)
             } else {
                 if (displayLabel.text?.last)! == "+"  {
//                     displayErrorMessage(.normal, from: displayLabel.text)
                 } else if  lastElement.isLastAnElement(displayLabel.text!) == true {
//                     showErrorMessage(.normal)
                 } else {
//                     pe.actuallyPrint(isTapped: isDeleteButtonTapped,
//                                      display: &displayLabel,
//                                      result: &resultLabel,
//                                      substitudeLabel: &ViewController.resultSubstitude,
//                                      element: .addition)
                 }
             }
         case 20:
             ViewController.temp = resultLabel.text ?? ""
             if isDeleteButtonTapped {
                 if lastElement.isLastAnElement(ViewController.resultSubstitude ?? "=") == true {
//                     displayErrorMessage(.normal, from: displayLabel.text)
                 } else {
                     if leftover.sameParanthesesCount(ViewController.resultSubstitude ?? "") {
                         ViewController.temp = ViewController.resultSubstitude
                         if lastElement.validToParse(ViewController.resultSubstitude ?? "") == true {
                             resultLabel.text = "\(ViewController.resultSubstitude?.calculate()?.truncate(places: 5) ?? 0)"
                             ViewController.resultSubstitude = nil
                         }
                         resultLabel.isHidden = false
                     } else {
                         isExtraParanthesesNeeded = true
                         let tempii = leftover.placeParatheses(ViewController.resultSubstitude!)
                         ViewController.resultSubstitude = "\(ViewController.resultSubstitude ?? "")\(tempii)"
                         print("Placing, endResult: \(String(describing: ViewController.resultSubstitude))")
                         ViewController.temp = ViewController.resultSubstitude
                         print("Temp: \(String(describing: ViewController.temp))")
                         if lastElement.validToParse(ViewController.temp!) {
                             resultLabel.text = "\(ViewController.temp!.calculate()!.truncate(places: 5))"
                         }
                         print("Ready to Show result: \(String(describing: resultLabel.text))")
                         ViewController.resultSubstitude = nil
                         resultLabel.isHidden = false
                     }
                 }
             } else {
                 if resultLabel.text != nil {
                     if lastElement.isLastAnElement(resultLabel.text!) == true {
//                         displayErrorMessage(.normal, from: displayLabel.text)
                         resultLabel.isHidden = true
                     } else {
                         if leftover.sameParanthesesCount(resultLabel.text!) {
                             if lastElement.validToParse(resultLabel.text!) == true {
                                 print("Valid to Parse: \(String(describing: resultLabel.text))")
                                 resultLabel.text = "\(resultLabel.text!.calculate()?.truncate(places: 5) ?? 0 )"
                                 resultLabel.isHidden = false
                             } else {
                                 print("Invalid to parse")
//                                 displayErrorMessage(.error, from: resultLabel.text)
                             }
                         } else {

                             if leftover.diffInParanthesesCount(resultLabel.text!) > 0 {
                                 let tempii = leftover.placeParatheses(resultLabel.text!)
                                 resultLabel.text = "\(resultLabel.text ?? "")\(tempii)"

                             } else {
                                 let tempii = leftover.placeParatheses(resultLabel.text!)
                                 print("We are here: \(tempii)")
                                 resultLabel.text = "\(tempii)\(resultLabel.text ?? "")"

                             }

                             print("Diff Para \(String(describing: resultLabel.text))")
                             if lastElement.validToParse(resultLabel.text!) == true {
                                 print("Valid to parse: And Barakets added:  YAAY \(String(describing: resultLabel.text))")
                                 resultLabel.text = "\(resultLabel.text!.calculate()?.truncate(places: 5) ?? 0 )"
                                 resultLabel.isHidden = false
                             } else {
                                 print("Does not compute")
//                                 displayErrorMessage(.error, from: resultLabel.text)
                             }

                         }
                     }
                 } else {
//                     displayErrorMessage(.nothing, from: displayLabel.text)
                 }
             }
         default:
             print(sender.tag)
         }
     }
}

extension UIView {
    
    public func constraintLeadingTrainlingToSuperview(leadingConstant: CGFloat = 0.0,
                                         trailingConstant: CGFloat = 0.0) {
        guard let superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leadingConstant).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: trailingConstant).isActive = true
    }
    public func constraintTopBottomToSuperview(topConstant: CGFloat = 0.0,
                                               bottomConstant: CGFloat = 0.0) {
        guard let superview else { return }
        topAnchor.constraint(equalTo: superview.topAnchor, constant: topConstant).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: bottomConstant).isActive = true
    }

}
