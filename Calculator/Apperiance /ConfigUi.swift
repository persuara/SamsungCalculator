//
//  ConfigUi.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 1/12/23.
//

import UIKit

class ConfigUi: UIView {
    public func stackView(spacing: CGFloat = 16.0, distribustion: UIStackView.Distribution = .fillEqually, axis: NSLayoutConstraint.Axis = .horizontal) -> UIStackView {
        let view: UIStackView = .init(frame: .zero)
        view.axis = axis
        view.distribution = distribustion
        view.spacing = spacing
        view.backgroundColor = .clear
        return view
    }
    public func label(numberOfLines: Int = 0,
                    isHidden: Bool = false,
                    alpha: CGFloat = 1,
                    backgroundColor: UIColor = .clear,
                    colors: [CGFloat] = [197.0, 163.0, 154.0], size: CGFloat = 28,
                    primaryAlpha: CGFloat = 1.0,
                    textAlignment: NSTextAlignment = .right,
                    cornerRadius: CGFloat = 0,
                    heightConstant: CGFloat = 40.0
    ) -> UILabel {
        let view: UILabel = .init(frame: .zero)
        view.textColor = UIColor.init(red: colors[0]/255.0, green: colors[1]/255.0, blue: colors[2]/255.0, alpha: alpha)
        view.font = UIFont(name: "Arial", size: size)
        view.backgroundColor = backgroundColor
        view.textAlignment = textAlignment
        view.numberOfLines = numberOfLines
        view.isHidden = isHidden
        view.alpha = primaryAlpha
        view.layer.cornerRadius = cornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    public func button() -> UIButton {
        let view: UIButton = .init(frame: .zero)
        view.setBackgroundImage(UIImage(systemName: "delete.left"), for: .normal)
        view.tintColor = UIColor(cgColor: CGColor(red: 197.0/255.0, green: 163.0/255.0, blue: 154.0/255.0, alpha: 1))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isEnabled = false
        return view
    }
    public func view(heightConstant: CGFloat = 2.0) -> UIView {
        let view: UIView = .init(frame: .zero)
        view.backgroundColor = UIColor(red: 40.0/255.0, green: 40.0/255.0, blue: 40.0/255.0, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
        return view
    }
}
