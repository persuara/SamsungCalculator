//
//  MainUI.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 1/3/23.
//

import UIKit

class MainUI: UIView {
    
    func stackView(spacing: CGFloat = 16.0, axis: NSLayoutConstraint.Axis = .horizontal) -> UIStackView {
        let view: UIStackView = .init(frame: .zero)
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = spacing
        view.backgroundColor = .clear
        return view
    }
    
    private lazy var cstacksArray: [UIView] = [
        rowOneStackView,
        rowTwoStackView,
        rowThreeStackView,
        rowFourStackView,
        rowFiveStackView,
        rowIconsStackView
    ]
    private lazy var mainStackView = stackView(spacing: 0, axis: .vertical)
    
    lazy var rowOneStackView = stackView()
    lazy var rowTwoStackView = stackView()
    lazy var rowThreeStackView = stackView()
    lazy var rowFourStackView = stackView()
    lazy var rowFiveStackView = stackView()
    lazy var rowIconsStackView = stackView(spacing: 35)
    
    private lazy var hairline: UIView = {
        let view = UIView()
        view.backgroundColor = .blue //UIColor(red: 24.0/255.0, green: 23.0/255.0, blue: 23.0/255.0, alpha: 1.0)
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .yellow
        
        addSubview(mainStackView)
        mainStackView.constraintAllToSuperview()
        
        addSubview(hairline)
        hairline.constraintAllToSuperview()
        
        cstacksArray.enumerated().forEach { [weak self] element in
            guard let self else { return }
            let colors: [UIColor] = [.red, .blue, .black, .green, .gray, .brown]
            element.element.backgroundColor = colors[element.offset]
            self.mainStackView.addArrangedSubview(element.element)
        }
        
        let constraints: [NSLayoutConstraint] = [
            hairline.topAnchor.constraint(equalTo: topAnchor),
            hairline.heightAnchor.constraint(equalToConstant: 5),
            
            mainStackView.topAnchor.constraint(equalTo: hairline.topAnchor, constant: 10),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIView {
    
    public func constraintAllToSuperview(leadingConstant: CGFloat = 0.0,
                                         trailingConstant: CGFloat = 0.0) {
        guard let superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        
        leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leadingConstant).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: trailingConstant).isActive = true
    }

}
