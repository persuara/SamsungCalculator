//
//  ViewController.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 12/20/22.
//

import UIKit
class ViewController: UIViewController {
    lazy var ui = MainUI()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(ui)
        ui.constraintTopBottomToSuperview(view: view, both: true, onlyTop: false, bottomConstant: -25)
        ui.setConstraints(both: true, isHeightWidthNeeded: false, leadingConstant: 15, trailingConstant: -15)
    }
    override func viewDidLayoutSubviews() {
        if ui.displayLabel.text != nil {
            ui.deleteButton.isEnabled = true
        } else {
            ui.deleteButton.isEnabled = false
        }
    }
}
