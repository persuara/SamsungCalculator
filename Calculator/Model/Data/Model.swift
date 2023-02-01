//
//  Model.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 1/2/23.
import Foundation
import UIKit
struct ModelButton {
    var title: String
    var backGroundColor: [CGFloat] = [24.0, 23.0, 23.0]
    var titleColor: [CGFloat] = [197.0, 163.0, 154.0]
    var font: String = "Arial"
    var size: Int = 27
}
@objc protocol ObjCDelegate: AnyObject {
   @objc func didTapDeleteButton(view: MainUI)
}
