//
//  MainUI.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 1/3/23.
//
import UIKit
class MainUI: UIView {
    
    static var resultSubstitude: String?
    static var temp: String?
    lazy var viewModel = ViewModel()
    lazy var config = ConfigUi()
    lazy var errorSetting = ErrorSettings()
    lazy var animate = Animation()
    var pe = Regulations()
    lazy var validate = Validation()
    lazy var leftover = Leftover()
    var result: String = ""
    var numbersTag: Int = 0
    var isDeleteButtonTapped: Bool = false
    var isLastCharElement: Bool = false
    var isExtraParanthesesNeeded: Bool = false
    private lazy var subviewArray: [UIView] = [displayLabel, resultLabel, deleteButton, hairline, mainStackView, errorMessage]
    private lazy var cstacksArray: [UIStackView] = [
        rowFiveStackView, rowFourStackView, rowThreeStackView, rowTwoStackView, rowOneStackView
    ]
    private lazy var mainStackView = config.stackView(spacing: 10, distribustion: .equalCentering, axis: .vertical)
    public lazy var displayLabel = config.label(heightConstant: 150)
    public lazy var resultLabel = config.label(numberOfLines: 1,isHidden: false, alpha: 0.7 ,size: 25)
    private lazy var rowOneStackView = config.stackView()
    private lazy var rowTwoStackView = config.stackView()
    private lazy var rowThreeStackView = config.stackView()
    private lazy var rowFourStackView = config.stackView()
    private lazy var rowFiveStackView = config.stackView()
    public lazy var deleteButton = config.button()
    private lazy var errorMessage = config.label(numberOfLines: 1, isHidden: false, backgroundColor: .gray.withAlphaComponent(0.7), size: 15, primaryAlpha: 0, textAlignment: .center, cornerRadius: 25.0, heightConstant: 50)
    private lazy var hairline = config.view()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        pe.label = displayLabel
        pe.resLabel = resultLabel
        errorSetting.label = errorMessage
        subviewArray.enumerated().forEach({ [weak self] element in
            guard self != nil else {return}
            addSubview(element.element)
        })
        
        mainStackView.setConstraints(isHeightWidthNeeded: false)
        mainStackView.constraintTopBottomToSuperview(view: self ,both: false, onlyTop: false)
        displayLabel.setConstraints(isHeightWidthNeeded: false, leadingConstant: 15, trailingConstant: -20)
        displayLabel.constraintTopBottomToSuperview(view: self ,both: false, onlyTop: true,topConstant: 20)
        
        hairline.setConstraints(isHeightWidthNeeded: false)
        deleteButton.addTarget(self, action: #selector(addDeleteFunctionality), for: .touchUpInside)
        deleteButton.setConstraints(isHeightWidthNeeded: true, widthConst: 23, heightConstant: 18)
        deleteButton.setConstraints(both: false, onlyTrail: true, isHeightWidthNeeded: false, trailingConstant: -40)
        resultLabel.setConstraints(isHeightWidthNeeded: false, leadingConstant: 20, trailingConstant: -30)
        resultLabel.constraintTopBottomToSuperview(view: displayLabel, both: false, onlyTop: true, topConstant: 240)
        errorMessage.setConstraints(isHeightWidthNeeded: true, widthConst: 190, heightConstant: 50)
        errorMessage.constraintTopBottomToSuperview(view: self,both: false, onlyTop: false, bottomConstant: -50)
        
        for i in 0...cstacksArray.count - 1 {
            cstacksArray[i].backgroundColor = .black
            mainStackView.addArrangedSubview(cstacksArray[i])
            addButton(3, from: viewModel.arrayOfArrays[i], which: cstacksArray[i])
        }
        
        let constraints: [NSLayoutConstraint] = [
            deleteButton.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 10),
            hairline.topAnchor.constraint(equalTo: deleteButton.bottomAnchor, constant: 20),
            mainStackView.topAnchor.constraint(equalTo: hairline.topAnchor, constant: 20),
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
    @objc func addDeleteFunctionality() -> Void {
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
                       MainUI.resultSubstitude = r
                       resultLabel.text = MainUI.temp
                       print("Inside Delete Button: ResultSubstitude =  \(MainUI.resultSubstitude ?? "")")
                       resultLabel.isHidden = true
                   }
               } else {
                   displayLabel.text = nil
                   deleteButton.isEnabled = false
                   resultLabel.isHidden = true
               }
           }
    
    @objc func addPrintFunctionality(_ sender: UIButton) -> Void {
        animate.animateButton(sender: sender, colors: [32.0, 30.0, 30.0, 1.0])
        if sender.tag == 20 {
            resultLabel.isHidden = false
        } else {
            hideResultLabel()
        }
        if sender.tag == 17 {
            print("computing sender.tag -- 17")
            pe.negatationRegulation(sender, on: &displayLabel.text)
            pe.negatationRegulation(sender, on: &resultLabel.text)
        } else if sender.tag == 1 { emptyAll() }
        
        else {
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
    public func hideResultLabel() {
        resultLabel.isHidden = true
    }
    public func emptyAll() {
        displayLabel.text = nil
        resultLabel.text = nil
        MainUI.temp = nil
    }
}
