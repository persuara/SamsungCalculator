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
    lazy var pe = Regulations()
    lazy var errorSetting = ErrorSettings()
    lazy var lastElement = Validation()
    lazy var leftover = Leftover()
    static var resultSubstitude: String?
    static var temp: String?
    
    var isDeleteButtonTapped: Bool = false
    var isLastCharElement: Bool = false
    var isExtraParanthesesNeeded: Bool = false
    
    private lazy var cstacksArray: [UIStackView] = [
        rowFiveStackView, rowFourStackView, rowThreeStackView, rowTwoStackView, rowOneStackView
    ]
    private lazy var mainStackView = config.stackView(spacing: 10, axis: .vertical)
    public lazy var displayLabel = config.label(backgroundColor: .blue)
    public lazy var resultLabel = config.label(numberOfLines: 1,isHidden: false, alpha: 0.7, backgroundColor: .yellow ,size: 25)
    private lazy var rowOneStackView = config.stackView()
    private lazy var rowTwoStackView = config.stackView()
    private lazy var rowThreeStackView = config.stackView()
    private lazy var rowFourStackView = config.stackView()
    private lazy var rowFiveStackView = config.stackView()
    public lazy var deleteButton = config.button()
    private lazy var errorMessage = config.label(numberOfLines: 1, isHidden: false, backgroundColor: .gray.withAlphaComponent(0.7), size: 15, primaryAlpha: 0, textAlignment: .center, cornerRadius: 25.0)
    
    private lazy var hairline: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 40.0/255.0, green: 40.0/255.0, blue: 40.0/255.0, alpha: 1.0)
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        pe.label = displayLabel
        pe.resLabel = resultLabel
        pe.temp = MainUI.temp
        
        addSubview(mainStackView)
        mainStackView.setConstraints(isHeightWidthNeeded: false)
        addSubview(displayLabel)
        displayLabel.setConstraints(isHeightWidthNeeded: false, leadingConstant: 15, trailingConstant: -20)
        addSubview(hairline)
        hairline.setConstraints(isHeightWidthNeeded: false)
        
        addSubview(deleteButton)
        deleteButton.addTarget(self, action: #selector(addDeleteFunctionality), for: .touchUpInside)
        deleteButton.setConstraints(isHeightWidthNeeded: true, widthConst: 23, heightConstant: 18)
        
        addSubview(resultLabel)
        resultLabel.setConstraints(isHeightWidthNeeded: false, leadingConstant: 20, trailingConstant: -30)
        
        addSubview(errorMessage)
        errorSetting.label = errorMessage
        errorMessage.setConstraints(isHeightWidthNeeded: true, widthConst: 190, heightConstant: 50)
        
        
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
            displayLabel.heightAnchor.constraint(equalToConstant: 150),
            
            resultLabel.topAnchor.constraint(equalTo: displayLabel.topAnchor, constant: 240),
            resultLabel.heightAnchor.constraint(equalToConstant: 40),
            

            deleteButton.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 10),
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            hairline.topAnchor.constraint(equalTo: deleteButton.bottomAnchor, constant: 20),
            hairline.heightAnchor.constraint(equalToConstant: 2),
            
            mainStackView.topAnchor.constraint(equalTo: hairline.topAnchor, constant: 20),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            errorMessage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            errorMessage.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
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
        MainUI.temp = nil
    }
    @objc func addDeleteFunctionality() -> Void {
            isDeleteButtonTapped = true
            var s: String?
            var r: String?
            guard let text = displayLabel.text else { return  deleteButton.isEnabled = false }
            s = text
            r = MainUI.temp
//          🫡
            if s?.isEmpty == false && r?.isEmpty == false {
                let absDiff = abs(leftover.diffInParanthesesCount(r!))
                print(" abs Different: \(absDiff)")
                if isExtraParanthesesNeeded {
                    print("Extra delete needed! x")
                    for _ in 0...absDiff{
                        r!.removeLast()
                    }
                    if s?.last == "%" {
                        for _ in 1...4 {
                            r!.removeLast()
                        }
                    }
//                    displayLabel.text = s
//                    MainUI.temp = r
//                    MainUI.resultSubstitude = r
                    isExtraParanthesesNeeded = !isExtraParanthesesNeeded
                } else {
                    print("Normal Delete")
                    s!.removeLast()
                    r!.removeLast()
                    displayLabel.text = s
                    
                }
            } else {
                displayLabel.text = nil
                deleteButton.isEnabled = false
                resultLabel.isHidden = true
            }
        MainUI.temp = r
        print("Inside Delete Button: Temp: \(MainUI.temp ?? "")")
        MainUI.resultSubstitude = r
        print("Inside Delete Button: ResultSubstitude =  \( MainUI.resultSubstitude ?? "")")
        }
    
    @objc func addPrintFunctionality(_ sender: UIButton) -> Void {
        animate.animateButton(sender: sender, colors: [32.0, 30.0, 30.0, 1.0])
        if sender.tag == 17 {
            print("computing sender.tag -- 17")
            pe.negatationRegulation(sender, on: &displayLabel.text)
            pe.negatationRegulation(sender, on: &resultLabel.text)
            pe.negatationRegulation(sender, on: &MainUI.temp)
        } else {
            pe.printTitle(sender, On: &displayLabel.text, sign: "×")
            pe.printTitle(sender, On: &resultLabel.text, sign: "*")
            pe.printTitle(sender, On: &MainUI.temp, sign: "*")
        }
        if sender.tag == 20 {              // you can fix this later
            resultLabel.isHidden = false
        } else {
            resultLabel.isHidden = false
        }
        
        switch sender.tag {
        case 1:
            emptyAll()
        case 20:
            
            print("before anything else, temp equals: \(MainUI.temp ?? "")")
            if isDeleteButtonTapped == true {
                print("Delete Button is tapped!")
                if lastElement.isLastAnElement( MainUI.resultSubstitude ?? "=") == true {
//                     Works! 🫡
                    errorSetting.displayErrorMessage(.normal, from: displayLabel.text)
                } else {
                    print("resultSubstitude: \(MainUI.resultSubstitude ?? "")")
                    if leftover.sameParanthesesCount( MainUI.resultSubstitude ?? "") {
                        print("SameParantheses")
                        print("resultSubstitude: \(MainUI.resultSubstitude ?? "")")
                        MainUI.temp =  MainUI.resultSubstitude
                        // CHANGED THIS
                        if lastElement.validToParse( MainUI.temp ?? "") == true {
                            resultLabel.text = "\( MainUI.temp?.calculate()?.truncate(places: 5) ?? 0)"
                        }
//                        isDeleteButtonTapped = !isDeleteButtonTapped
                        MainUI.resultSubstitude = nil
                        resultLabel.isHidden = false
                    } else {
                        print("In need of parantheses!")
                        isExtraParanthesesNeeded = true
                        let tempii = leftover.placeParatheses(MainUI.resultSubstitude!)
                        MainUI.resultSubstitude = "\(MainUI.resultSubstitude ?? "")\(tempii)"
                        print("Placing, endResult: \(String(describing: MainUI.resultSubstitude))")
                        MainUI.temp = MainUI.resultSubstitude
                        print("Temp: \(String(describing: MainUI.temp))")
                        if lastElement.validToParse(MainUI.temp!) {
                            resultLabel.text = "\(MainUI.temp!.calculate()!.truncate(places: 5))"
                        }
                        print("Ready to Show result: \(String(describing: resultLabel.text))")
                        MainUI.resultSubstitude = nil
                        resultLabel.isHidden = false

                    }
                }
                isDeleteButtonTapped = !isDeleteButtonTapped
                
            } else {
                
                if resultLabel.text != nil {
                    if lastElement.isLastAnElement(resultLabel.text!) == true {
                        errorSetting.displayErrorMessage(.normal, from: displayLabel.text)
                        resultLabel.isHidden = true
                    } else {
                        if leftover.sameParanthesesCount(resultLabel.text!) {
                            if lastElement.validToParse(resultLabel.text!) == true {
                                print("Valid to Parse: \(String(describing: MainUI.temp!))")
                                resultLabel.text = "\(MainUI.temp!.calculate()?.truncate(places: 5) ?? 0 )"
                                resultLabel.isHidden = false
                            } else {
                                print("Invalid to parse")
                                errorSetting.displayErrorMessage(.error, from: resultLabel.text)
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
                                errorSetting.displayErrorMessage(.error, from: resultLabel.text)
                            }
                            
                        }
                    }
                } else {
                    errorSetting.displayErrorMessage(.nothing, from: displayLabel.text)
                }
            }
        default:
//            MainUI.temp = resultLabel.text ?? ""
            print("---------")
        }
    }
}
extension UIView {
    public func constraintTopBottomToSuperview(topConstant: CGFloat = 0.0,
                                               bottomConstant: CGFloat = 0.0) {
        guard let superview else { return }
        topAnchor.constraint(equalTo: superview.topAnchor, constant: topConstant).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: bottomConstant).isActive = true
    }

    public func setConstraints(isHeightWidthNeeded: Bool, leadingConstant: CGFloat = 0.0,
                               trailingConstant: CGFloat = 0.0, widthConst: CGFloat = 0.0, heightConstant: CGFloat =  0.0) {
        guard let superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        
        if isHeightWidthNeeded == true {
            widthAnchor.constraint(equalToConstant: widthConst).isActive = true
            heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
        } else {
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leadingConstant).isActive = true
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: trailingConstant).isActive = true
        }
    }
}
