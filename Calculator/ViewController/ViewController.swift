//
//  ViewController.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 12/20/22.
//

import UIKit

class ViewController: UIViewController {
    
    var delegate: NumbersDelegate?
    var numbersTag: Int = 0
    
    lazy var viewModel = ViewModel()
    lazy var ui = MainUI()
    lazy var pe = Print()
    lazy var leftover = Leftover()
    lazy var animate = Animation()
    lazy var errorSetting = ErrorSettings()
    lazy var lastElement = Validation()
    lazy var calculation = Calculation()
    var currentLabel: ErrorMessage?
    
    static var temp: String?
    static var resultSubstitude: String?
    
    var currentStatus: Validity?
    var isDeleteButtonTapped: Bool = false
    var shouldShowErrorMessage: Bool = false
    var isLastCharElement: Bool = false
    
    
    lazy var displayLabel: UILabel = {
        let view: UILabel = .init(frame: .zero)
        view.textColor = UIColor.init(red: 197.0/255.0, green: 163.0/255.0, blue: 154.0/255.0, alpha: 1.0)
        view.font = UIFont(name: "Arial", size: 28)
        view.textAlignment = .right
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var resultLabel: UILabel = {
        let view: UILabel = .init(frame: .zero)
        view.textColor = UIColor.init(red: 197.0/255.0, green: 163.0/255.0, blue: 154.0/255.0, alpha: 0.7)
        view.font = UIFont(name: "Arial", size: 28)
        view.textAlignment = .right
        view.isHidden = true
        view.numberOfLines = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var deleteIcon: UIButton = {
        let view: UIButton = .init(frame: .zero)
        view.setBackgroundImage(UIImage(systemName: "delete.left"), for: .normal)
        view.tintColor = UIColor(cgColor: CGColor(red: 197.0/255.0, green: 163.0/255.0, blue: 154.0/255.0, alpha: 1))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isEnabled = false
        view.addTarget(self, action: #selector(addDeleteFunctionality), for: .touchUpInside)
        return view
    }()
    lazy var errorMessage: UIButton = {
        let view: UIButton = .init(frame: .zero)
        view.setTitle("Invalid format used.", for: .normal)
        view.titleLabel?.font = UIFont.init(name: "Ariel", size: 15)
        view.backgroundColor = .white.withAlphaComponent(0.3)
        view.setTitleColor(.white, for: .normal)
        view.alpha = 0
        view.layer.cornerRadius = 25
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate func configureStackView() {
        
        ui.addAllToSuperView(view)
        
        addButtonIconStack(2, from: viewModel.iconArray)
        addButton(6, from: viewModel.stack5Array, which: ui.rowFiveStackView)
        addButton(6, from: viewModel.stack4Array, which: ui.rowFourStackView)
        addButton(6, from: viewModel.stack3Array, which: ui.rowThreeStackView)
        addButton(6, from: viewModel.stack2Array, which: ui.rowTwoStackView)
        addButton(6, from: viewModel.stack1Array, which: ui.rowOneStackView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureStackView()

        
        view.addSubview(ui.straightView)
        view.addSubview(deleteIcon)
        view.addSubview(displayLabel)
        view.addSubview(resultLabel)
        view.addSubview(errorMessage)
        
        NSLayoutConstraint.activate([
            ui.straightView.widthAnchor.constraint(equalToConstant: 800),
            ui.straightView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            ui.straightView.bottomAnchor.constraint(equalTo: ui.rowFiveStackView.topAnchor, constant: -20),
            ui.straightView.heightAnchor.constraint(equalToConstant: 2),
            deleteIcon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            deleteIcon.heightAnchor.constraint(equalToConstant: 20),
            deleteIcon.widthAnchor.constraint(equalToConstant: 25),
            deleteIcon.bottomAnchor.constraint(equalTo: ui.straightView.topAnchor, constant: -30),
            
            displayLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            displayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            displayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            displayLabel.heightAnchor.constraint(equalToConstant: 200),
            
            resultLabel.bottomAnchor.constraint(equalTo: deleteIcon.topAnchor, constant: -20),
            resultLabel.trailingAnchor.constraint(equalTo: deleteIcon.trailingAnchor, constant: 0),
            resultLabel.widthAnchor.constraint(equalToConstant: 200),
            resultLabel.heightAnchor.constraint(equalToConstant: 70),
            
            errorMessage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            errorMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            errorMessage.widthAnchor.constraint(equalToConstant: 190),
            errorMessage.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    override func viewDidLayoutSubviews() {
        
        if displayLabel.text != nil {
            deleteIcon.isEnabled = true
        } else {
            deleteIcon.isEnabled = false
        }
    }
    
    func addButtonIconStack(_ number: Int, from array: [ModelButton]) -> Void {
        for i in 0...number {
            let btn: UIButton = .init(frame: .zero)
            btn.setImage(UIImage(systemName: array[i].title), for: .normal)
            btn.tintColor = UIColor(cgColor: CGColor(red: array[i].titleColor[0]/255.0, green: array[i].titleColor[1]/255.0, blue: array[i].titleColor[2]/255.0, alpha: 1.0))
            ui.rowIconsStackView.addArrangedSubview(btn)
            if i == 0 {
                btn.transform = CGAffineTransform.init(rotationAngle: 1.6)
            }
        }
    }
    func addButton(_ number: Int, from array: [ModelButton], which stack: UIStackView) -> Void {
        for i in 0...number {
            numbersTag += 1
            let btn: UIButton = .init(frame: .zero)
            btn.tag = numbersTag
            btn.setTitle(array[i].title, for: .normal)
            btn.layer.cornerRadius = 40
            btn.setTitleColor(UIColor(cgColor: CGColor(red: array[i].titleColor[0]/255.0, green: array[i].titleColor[1]/255.0, blue: array[i].titleColor[2]/255.0, alpha: 1.0)), for: .normal)
            btn.backgroundColor = UIColor(cgColor: CGColor(red: array[i].backGroundColor[0]/255.0, green: array[i].backGroundColor[1]/255.0, blue: array[i].backGroundColor[2]/255.0, alpha: 1.0))
            btn.titleLabel?.font = UIFont.init(name: array[i].font, size: CGFloat(array[i].size))
            
            btn.addTarget(self, action: #selector(addPrintFunctionality), for: .touchUpInside)
            stack.addArrangedSubview(btn)
        }
    }
    @objc func addPrintFunctionality(_ sender: UIButton) -> Void {
        animate.animateButton(sender: sender)
        for _ in 0...sender.tag {
            hideResultLabel()
            if sender.tag == 35 {
                currentLabel = .nothing
            } else {
                errorMessage.titleLabel?.text = "Nothing to compute!"
            }
            
        }
        
        switch sender.tag {
        case 4:
            emptyAll()
           
        case 5:
            pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                             display: &displayLabel,
                             result: &resultLabel,
                             substitudeLabel: &ViewController.resultSubstitude,
                             element: .parantheses)
        case 6:
            if displayLabel.text == nil {
                showErrorMessage(.normal)
            } else {
                if (displayLabel.text?.last)! == "%"  {
                    showErrorMessage(.normal)
                } else if  lastElement.isLastAnElement(displayLabel.text!) == true {
                    showErrorMessage(.normal)
                } else {
                    pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                                     display: &displayLabel,
                                     result: &resultLabel,
                                     substitudeLabel: &ViewController.resultSubstitude,
                                     element: .percentage)
                }
            }
        case 7:
            if displayLabel.text == nil {
                showErrorMessage(.normal)
            } else {
                if (displayLabel.text?.last)! == "÷"  {
                    showErrorMessage(.normal)
                } else if lastElement.isLastAnElement(displayLabel.text!) == true {
                    showErrorMessage(.normal)
                } else {
                    pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                                     display: &displayLabel,
                                     result: &resultLabel,
                                     substitudeLabel: &ViewController.resultSubstitude,
                                     element: .division)
                }
            }
        case 11:
            pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                             display: &displayLabel,
                             result: &resultLabel,
                             substitudeLabel: &ViewController.resultSubstitude,
                             element: .seven)
        case 12:
            pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                             display: &displayLabel,
                             result: &resultLabel,
                             substitudeLabel: &ViewController.resultSubstitude,
                             element: .eight)
        case 13:
            pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                             display: &displayLabel,
                             result: &resultLabel,
                             substitudeLabel: &ViewController.resultSubstitude,
                             element: .nine)
        case 14:
            if displayLabel.text == nil {
                showErrorMessage(.normal)
            } else {
                if (displayLabel.text?.last)! == "×"  {
                    showErrorMessage(.normal)
                } else if  lastElement.isLastAnElement(displayLabel.text!) == true {
                    showErrorMessage(.normal)
                } else {
                    pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                                     display: &displayLabel,
                                     result: &resultLabel,
                                     substitudeLabel: &ViewController.resultSubstitude,
                                     element: .multiplication)
                }
            }
        case 18:
            pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                             display: &displayLabel,
                             result: &resultLabel,
                             substitudeLabel: &ViewController.resultSubstitude,
                             element: .four)
        case 19:
            pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                             display: &displayLabel,
                             result: &resultLabel,
                             substitudeLabel: &ViewController.resultSubstitude,
                             element: .five)
            
        case 20:
            pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                             display: &displayLabel,
                             result: &resultLabel,
                             substitudeLabel: &ViewController.resultSubstitude,
                             element: .six)
        case 21:
            if displayLabel.text == nil {
                showErrorMessage(.normal)
            } else {
                if (displayLabel.text?.last)! == "-"  {
                    showErrorMessage(.normal)
                } else if  lastElement.isLastAnElement(displayLabel.text!) == true {
                    showErrorMessage(.normal)
                } else {
                    pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                                     display: &displayLabel,
                                     result: &resultLabel,
                                     substitudeLabel: &ViewController.resultSubstitude,
                                     element: .subtraction)
                }
            }
        case 25:
            pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                             display: &displayLabel,
                             result: &resultLabel,
                             substitudeLabel: &ViewController.resultSubstitude,
                             element: .one)
            
        case 26:
            pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                             display: &displayLabel,
                             result: &resultLabel,
                             substitudeLabel: &ViewController.resultSubstitude,
                             element: .two)
            
        case 27:
            pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                             display: &displayLabel,
                             result: &resultLabel,
                             substitudeLabel: &ViewController.resultSubstitude,
                             element: .three)
            
        case 28:
            if displayLabel.text == nil {
                showErrorMessage(.normal)
            } else {
                if (displayLabel.text?.last)! == "+"  {
                    showErrorMessage(.normal)
                } else if  lastElement.isLastAnElement(displayLabel.text!) == true {
                    showErrorMessage(.normal)
                } else {
                    pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                                     display: &displayLabel,
                                     result: &resultLabel,
                                     substitudeLabel: &ViewController.resultSubstitude,
                                     element: .addition)
                }
            }
        case 32:
            pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                             display: &displayLabel,
                             result: &resultLabel,
                             substitudeLabel: &ViewController.resultSubstitude,
                             element: .negetive)
            
        case 33:
            pe.actuallyPrint(isTapped: isDeleteButtonTapped,
                             display: &displayLabel,
                             result: &resultLabel,
                             substitudeLabel: &ViewController.resultSubstitude,
                             element: .zero)
        case 34:
            ViewController.temp = resultLabel.text ?? ""
            if isDeleteButtonTapped {
                pe.printElementOnTemp(&ViewController.resultSubstitude, .decimal)
            } else {
                pe.printElementOnDisplay(&displayLabel.text, .decimal)
                pe.printElementOnResultLabel(&resultLabel.text, .decimal)
            }
        case 35:
            ViewController.temp = resultLabel.text ?? ""
            currentLabel = .nothing
            calculation.calculateResult(which: resultLabel,
                                        isTapped: isDeleteButtonTapped,
                                        temp: &ViewController.temp,
                                        substitude: &ViewController.resultSubstitude,
                                        labelError: currentLabel!
            )
        default:
            print(sender.tag)
        }
    }
    
    func hideResultLabel() {
        resultLabel.isHidden = true
    }
    
    @objc func addDeleteFunctionality() -> Void {
        isDeleteButtonTapped = true
        var s: String?
        var r: String?
        guard let text = displayLabel.text else { return  deleteIcon.isEnabled = false }
        s = text
        r = ViewController.temp
        if s?.isEmpty == false && r?.isEmpty == false {
            s!.removeLast()
            r!.removeLast()
            displayLabel.text = s
            ViewController.temp = r
            ViewController.resultSubstitude = r

            print("Inside Delete Button: Temp =  \(ViewController.resultSubstitude ?? "")")
        } else {
            displayLabel.text = nil
            deleteIcon.isEnabled = false
            resultLabel.isHidden = true
        }
    }
    private func emptyAll() {
        displayLabel.text = nil
        resultLabel.text = nil
        ViewController.temp = nil
    }
    
    //    ---TODO FIX THIS SHIT
    public func displayErrorMessage(_ text: String?) {
        if text == nil {
            errorMessage.alpha = 1
            UIView.animate(withDuration: 10.5, delay: 2, options: .transitionCurlUp ,animations: { () -> Void in
                self.errorMessage.alpha = 0.2
            })
        } else {
            viewModel.arrayOfElements.forEach({ c in
                if text?.last == c {
                    errorMessage.alpha = 1
                    UIView.animate(withDuration: 10.5, delay: 2, options: .transitionCurlUp, animations: { () -> Void in
                        self.errorMessage.alpha = 0.2
                    })
                }
            })
        }
    }
    public func showErrorMessage(_ modelText: ErrorMessage) {
        errorMessage.alpha = 1
        self.errorMessage.titleLabel?.text = modelText.rawValue
        UIView.animate(withDuration: 2.5, animations: { () -> Void in
            self.errorMessage.alpha = 0
        })
        self.errorMessage.reloadInputViews()
    }
}
extension ViewController: NumbersDelegate {
    func didNumbersTapped(_ viewController: ViewController, which tag: Int) {
    }
}
