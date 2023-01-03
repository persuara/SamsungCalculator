//
//  MainUI.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 1/3/23.
//

import UIKit

class MainUI: UIView {
    
    var cstacksArray = [UIStackView]()
    lazy var rowOneStackView: UIStackView = {
        let view: UIStackView = .init(frame: .zero)
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 15
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var rowTwoStackView: UIStackView = {
        let view: UIStackView = .init(frame: .zero)
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 16
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var rowThreeStackView: UIStackView = {
        let view: UIStackView = .init(frame: .zero)
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 16
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var rowFourStackView: UIStackView = {
        let view: UIStackView = .init(frame: .zero)
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 16
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var rowFiveStackView: UIStackView = {
        let view: UIStackView = .init(frame: .zero)
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 16
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var rowIconsStackView: UIStackView = {
        let view: UIStackView = .init(frame: .zero)
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 35
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var straightView: UIView = {
        let view: UIView = .init(frame: .zero)
        view.layer.borderColor = CGColor(red: 24.0/255.0, green: 23.0/255.0, blue: 23.0/255.0, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 2
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        cstacksArray.append(rowOneStackView)
        cstacksArray.append(rowTwoStackView)
        cstacksArray.append(rowThreeStackView)
        cstacksArray.append(rowFourStackView)
        cstacksArray.append(rowFiveStackView)
        cstacksArray.append(rowIconsStackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addAllToSuperView(_ superView: UIView) -> Void {
        cstacksArray.forEach({ c in
            superView.addSubview(c)
        })
        NSLayoutConstraint.activate([
            rowOneStackView.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -60),
            rowOneStackView.widthAnchor.constraint(equalToConstant: 650),
            rowOneStackView.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -15),
            rowOneStackView.heightAnchor.constraint(equalToConstant: 80),
            
            rowTwoStackView.bottomAnchor.constraint(equalTo: rowOneStackView.topAnchor, constant: -10),
            rowTwoStackView.widthAnchor.constraint(equalToConstant: 650),
            rowTwoStackView.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -15),
            rowTwoStackView.heightAnchor.constraint(equalToConstant: 80),
            
            rowThreeStackView.bottomAnchor.constraint(equalTo: rowTwoStackView.topAnchor, constant: -10),
            rowThreeStackView.widthAnchor.constraint(equalToConstant: 650),
            rowThreeStackView.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -15),
            rowThreeStackView.heightAnchor.constraint(equalToConstant: 80),
            
            rowFourStackView.bottomAnchor.constraint(equalTo: rowThreeStackView.topAnchor, constant: -10),
            rowFourStackView.widthAnchor.constraint(equalToConstant: 650),
            rowFourStackView.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -15),
            rowFourStackView.heightAnchor.constraint(equalToConstant: 80),
            
            rowFiveStackView.bottomAnchor.constraint(equalTo: rowFourStackView.topAnchor, constant: -10),
            rowFiveStackView.widthAnchor.constraint(equalToConstant: 650),
            rowFiveStackView.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -15),
            rowFiveStackView.heightAnchor.constraint(equalToConstant: 80),
            
            rowIconsStackView.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 35),
            rowIconsStackView.heightAnchor.constraint(equalToConstant: 24),
            rowIconsStackView.widthAnchor.constraint(equalToConstant: 142),
            rowIconsStackView.bottomAnchor.constraint(equalTo: rowFiveStackView.topAnchor, constant: -40)
        ])
    }
    
}

