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
    lazy var animate = Animation()
    lazy var pe = Print()
    lazy var lastElement = Validation()
    lazy var leftover = Leftover()
    var isDeleteButtonTapped: Bool = false
    var isLastCharElement: Bool = false
    var isExtraParanthesesNeeded: Bool = false
    
    private func stackView(spacing: CGFloat = 16.0, axis: NSLayoutConstraint.Axis = .horizontal) -> UIStackView {
        let view: UIStackView = .init(frame: .zero)
        view.axis = axis
        view.distribution = .fillEqually
        view.spacing = spacing
        view.backgroundColor = .clear
        return view
    }
    private func label(numberOfLines: Int = 1, isHidden: Bool = false, alpha: CGFloat = 1, color: UIColor = .clear, size: CGFloat = 28) -> UILabel {
        let view: UILabel = .init(frame: .zero)
        view.textColor = UIColor.init(red: 197.0/255.0, green: 163.0/255.0, blue: 154.0/255.0, alpha: alpha)
        view.font = UIFont(name: "Arial", size: size)
        view.backgroundColor = color
        view.textAlignment = .right
        view.numberOfLines = numberOfLines
        view.isHidden = isHidden
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    private func button() -> UIButton {
        let view: UIButton = .init(frame: .zero)
        view.setBackgroundImage(UIImage(systemName: "delete.left"), for: .normal)
        view.tintColor = UIColor(cgColor: CGColor(red: 197.0/255.0, green: 163.0/255.0, blue: 154.0/255.0, alpha: 1))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isEnabled = false
        return view
    }
    
    private lazy var cstacksArray: [UIStackView] = [
        rowFiveStackView, rowFourStackView, rowThreeStackView, rowTwoStackView, rowOneStackView
    ]
    private lazy var mainStackView = stackView(spacing: 10, axis: .vertical)
    
    lazy var displayLabel = label()
    lazy var resultLabel = label(numberOfLines: 1, isHidden: false, alpha: 0.7, size: 25)
    lazy var rowOneStackView = stackView()
    lazy var rowTwoStackView = stackView()
    lazy var rowThreeStackView = stackView()
    lazy var rowFourStackView = stackView()
    lazy var rowFiveStackView = stackView()
    lazy var deleteButton = button()
    
    private lazy var hairline: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 40.0/255.0, green: 40.0/255.0, blue: 40.0/255.0, alpha: 1.0)
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        
        addSubview(mainStackView)
        mainStackView.constraintLeadingTrainlingToSuperview()
        
        addSubview(displayLabel)
        displayLabel.constraintLeadingTrainlingToSuperview(leadingConstant: 15, trailingConstant: -20)
//        displayLabel.constraintTopBottomToSuperview(topConstant: 10, bottomConstant: -700)
        
        
        addSubview(hairline)
        hairline.constraintLeadingTrainlingToSuperview()
        
        addSubview(deleteButton)

        addSubview(resultLabel)
        resultLabel.constraintLeadingTrainlingToSuperview(leadingConstant: 20, trailingConstant: -30)
        
        
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
            resultLabel.heightAnchor.constraint(equalToConstant: 40),

        
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
//    public func displayErrorMessage(_ modelText: ErrorMessage, from text: String?) {
//        if text == nil {
//            errorMessage.alpha = 1
//            errorMessage.text = modelText.rawValue
//            UIView.animate(withDuration: 3.1, delay: 0.1, options: .curveLinear ,animations: { () -> Void in
//                self.errorMessage.alpha = 0
//            })
//        } else {
//            if lastElement.validToParse(text!) != true {
//                errorMessage.alpha = 1
//                errorMessage.text = modelText.rawValue
//                UIView.animate(withDuration: 3.1, delay: 0.1, options: .curveLinear, animations: { () -> Void in
//                    self.errorMessage.alpha = 0
//                })
//            }
//            viewModel.arrayOfElements.forEach({ c in
//                if text?.last == c {
//                    errorMessage.alpha = 1
//                    errorMessage.text = modelText.rawValue
//                    UIView.animate(withDuration: 3.1, delay: 0.1, options: .curveLinear, animations: { () -> Void in
//                        self.errorMessage.alpha = 0
//                    })
//                }
//            })
//        }
//    }
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
         for _ in 0...sender.tag {
             hideResultLabel()

             if sender.tag == 35 {
                 resultLabel.isHidden = false
             }
         }
         switch sender.tag {
         case 1:
             emptyAll()

         case 2:
             pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                              display: &displayLabel,
                              result: &resultLabel,
                              substitudeLabel: &ViewController.resultSubstitude,
                              element: .parantheses)
         case 3:
             if displayLabel.text == nil {
//                 displayErrorMessage(.normal, from: displayLabel.text)
             } else {
                 if (displayLabel.text?.last)! == "%"  {
//                     displayErrorMessage(.normal, from: displayLabel.text)
                 } else if  lastElement.isLastAnElement(displayLabel.text!) == true {
//                     displayErrorMessage(.normal, from: displayLabel.text)
                 } else {
                     pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                                      display: &displayLabel,
                                      result: &resultLabel,
                                      substitudeLabel: &ViewController.resultSubstitude,
                                      element: .percentage)
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
                     pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                                      display: &displayLabel,
                                      result: &resultLabel,
                                      substitudeLabel: &ViewController.resultSubstitude,
                                      element: .division)
                 }
             }
         case 5:
             pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                              display: &displayLabel,
                              result: &resultLabel,
                              substitudeLabel: &ViewController.resultSubstitude,
                              element: .seven)
         case 6:
             pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                              display: &displayLabel,
                              result: &resultLabel,
                              substitudeLabel: &ViewController.resultSubstitude,
                              element: .eight)
         case 7:
             pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                              display: &displayLabel,
                              result: &resultLabel,
                              substitudeLabel: &ViewController.resultSubstitude,
                              element: .nine)
         case 8:
             if displayLabel.text == nil {
//                 showErrorMessage(.normal)
             } else {
                 if (displayLabel.text?.last)! == "×"  {
//                     displayErrorMessage(.normal, from: displayLabel.text)
                 } else if  lastElement.isLastAnElement(displayLabel.text!) == true {
//                     displayErrorMessage(.normal, from: displayLabel.text)
                 } else {
                     pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                                      display: &displayLabel,
                                      result: &resultLabel,
                                      substitudeLabel: &ViewController.resultSubstitude,
                                      element: .multiplication)
                 }
             }
         case 9:
             pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                              display: &displayLabel,
                              result: &resultLabel,
                              substitudeLabel: &ViewController.resultSubstitude,
                              element: .four)
         case 10:
             pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                              display: &displayLabel,
                              result: &resultLabel,
                              substitudeLabel: &ViewController.resultSubstitude,
                              element: .five)

         case 11:
             pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                              display: &displayLabel,
                              result: &resultLabel,
                              substitudeLabel: &ViewController.resultSubstitude,
                              element: .six)
         case 12:
             if displayLabel.text == nil {
//                 showErrorMessage(.normal)
             } else {
                 if (displayLabel.text?.last)! == "-"  {
//                     displayErrorMessage(.normal, from: displayLabel.text)
                 } else if  lastElement.isLastAnElement(displayLabel.text!) == true {
//                     displayErrorMessage(.normal, from: displayLabel.text)
                 } else {
                     pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                                      display: &displayLabel,
                                      result: &resultLabel,
                                      substitudeLabel: &ViewController.resultSubstitude,
                                      element: .subtraction)
                 }
             }
         case 13:
             pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                              display: &displayLabel,
                              result: &resultLabel,
                              substitudeLabel: &ViewController.resultSubstitude,
                              element: .one)

         case 14:
             pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                              display: &displayLabel,
                              result: &resultLabel,
                              substitudeLabel: &ViewController.resultSubstitude,
                              element: .two)

         case 15:
             pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                              display: &displayLabel,
                              result: &resultLabel,
                              substitudeLabel: &ViewController.resultSubstitude,
                              element: .three)

         case 16:
             if displayLabel.text == nil {
//                 showErrorMessage(.normal)
             } else {
                 if (displayLabel.text?.last)! == "+"  {
//                     displayErrorMessage(.normal, from: displayLabel.text)
                 } else if  lastElement.isLastAnElement(displayLabel.text!) == true {
//                     showErrorMessage(.normal)
                 } else {
                     pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                                      display: &displayLabel,
                                      result: &resultLabel,
                                      substitudeLabel: &ViewController.resultSubstitude,
                                      element: .addition)
                 }
             }
         case 17:
             pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                              display: &displayLabel,
                              result: &resultLabel,
                              substitudeLabel: &ViewController.resultSubstitude,
                              element: .negetive)

         case 18:
             pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                              display: &displayLabel,
                              result: &resultLabel,
                              substitudeLabel: &ViewController.resultSubstitude,
                              element: .zero)
         case 19:
             ViewController.temp = resultLabel.text ?? ""
             pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                              display: &displayLabel,
                              result: &resultLabel,
                              substitudeLabel: &ViewController.resultSubstitude,
                              element: .decimal)
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
