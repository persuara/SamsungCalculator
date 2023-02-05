//
//  MainUI.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 1/3/23.
//
import UIKit
class MainUI: UIView {
    weak var delegate: ObjCDelegate?
    static var enteredElementsArray = [String]()
    lazy var calculator = Calculator()
    static var temp: String?
    lazy var viewModel = ViewModel()
    lazy var config = ConfigUi()
    lazy var errorSetting = ErrorSettings()
    lazy var animate = Animation()
    lazy var pe = Regulations()
    lazy var validate = Validation()
    lazy var leftover = Leftover()
    var result: String = ""
    var numbersTag: Int = 0
    var isDeleteButtonTapped: Bool = false
    var isLastCharElement: Bool = false
    var isExtraParanthesesNeeded: Bool = false
    var is15characters: Bool = true
    private lazy var subviewArray: [UIView] = [displayLabel, resultLabel, deleteButton, hairline, mainStackView, errorMessage]
    private lazy var cstacksArray = [UIStackView]()
    private lazy var mainStackView = config.stackView(spacing: 10, distribustion: .equalCentering, axis: .vertical)
    private lazy var errorMessage = config.label(numberOfLines: 1, isHidden: false, backgroundColor: .gray.withAlphaComponent(0.7), size: 15, primaryAlpha: 0, textAlignment: .center, cornerRadius: 25.0, heightConstant: 50)
    private lazy var hairline = config.view()
    public lazy var displayLabel = config.label(heightConstant: 150)
    public lazy var resultLabel = config.label(numberOfLines: 1,isHidden: false, alpha: 0.7 ,size: 25)
    public lazy var deleteButton = config.button()
    override init(frame: CGRect) {
        super.init(frame: frame)
        pe.label = displayLabel
        pe.resLabel = resultLabel
        errorSetting.label = errorMessage
        subviewArray.enumerated().forEach({ [weak self] element in
            guard self != nil else {return}
            addSubview(element.element)
        })
        for i in 0...4 {
            lazy var stack: UIStackView = config.stackView()
            cstacksArray.append(stack)
            mainStackView.addArrangedSubview(stack)
            mainStackView.addArrangedSubview(cstacksArray[i])
            addButton(3, from: viewModel.arrayOfArrays[i], which: cstacksArray[i])
        }
        mainStackView.setConstraints(isHeightWidthNeeded: false) // 2
        mainStackView.constraintTopBottomToSuperview(view: self ,both: false, onlyTop: false) // 1
        mainStackView.constraintTopBottomToSuperview(view: hairline, both: false, onlyTop: true ,topConstant: 20) // 1
        displayLabel.setConstraints(isHeightWidthNeeded: false, leadingConstant: 15, trailingConstant: -20) // 1
        displayLabel.constraintTopBottomToSuperview(view: self ,both: false, onlyTop: true,topConstant: 20) // 1
        hairline.setConstraints(isHeightWidthNeeded: false) // 2
        deleteButton.addTarget(self, action: #selector(delegate?.didTapDeleteButton), for: .touchUpInside) // 1
        deleteButton.setConstraints(isHeightWidthNeeded: true, widthConst: 23, heightConstant: 18) // 1
        deleteButton.setConstraints(both: false, onlyTrail: true, isHeightWidthNeeded: false, trailingConstant: -40) // 1
        resultLabel.setConstraints(isHeightWidthNeeded: false, leadingConstant: 20, trailingConstant: -30) // 1
        resultLabel.constraintTopBottomToSuperview(view: displayLabel, both: false, onlyTop: true, topConstant: 240) // 1
        errorMessage.setConstraints(isHeightWidthNeeded: true, widthConst: 190, heightConstant: 50) // 1
        errorMessage.constraintTopBottomToSuperview(view: self,both: false, onlyTop: false, bottomConstant: -50) // 1
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 10),
            hairline.topAnchor.constraint(equalTo: deleteButton.bottomAnchor, constant: 20),
            errorMessage.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
