//
//  File.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 1/2/23.
//

import Foundation
import UIKit

struct ModelButton {
    var title: String
    var backGroundColor: [CGFloat]
    var titleColor: [CGFloat]
    var font: String
    var size: Int
}

@objc protocol ObjCDelegate: AnyObject {
   @objc func didTapDeleteButton(view: MainUI)
    @objc func didTapPrint(view: MainUI, sender: UIButton)
}
