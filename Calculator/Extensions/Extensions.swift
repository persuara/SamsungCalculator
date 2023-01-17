//
//  Extensions.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 1/3/23.
//

import Foundation
import UIKit

extension UIView {
    
    public func constraintTopBottomToSuperview(view: UIView,both: Bool = true, onlyTop: Bool = false ,topConstant: CGFloat = 0.0,
                                               bottomConstant: CGFloat = 0.0) {
        //        guard let superview else { return }
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
    //    public func setTopToBottom(view: UIView ,topToBottom: Bool = true, constant: CGFloat = 0.0) {
    //        if topToBottom {
    //            topAnchor.constraint(equalTo: view.bottomAnchor, constant: constant).isActive = true
    //        } else {
    //            bottomAnchor.constraint(equalTo: view.topAnchor, constant: constant).isActive = true
    //        }
    //    }
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
    func calculate() -> Double {
        let expr = NSExpression(format: self)
        return expr.expressionValue(with: nil, context: nil) as! Double
        }
    
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
        
    }
    
