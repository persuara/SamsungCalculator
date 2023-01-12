//
//  ViewController.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 12/20/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    lazy var ui = MainUI()
    lazy var errorSetting = ErrorSettings()
    
    static var resultSubstitude: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        ui.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ui)
        
        let constraints: [NSLayoutConstraint] = [
            ui.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            ui.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            ui.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            ui.topAnchor.constraint(equalTo: view.topAnchor)]
        NSLayoutConstraint.activate(constraints)
    }
    override func viewDidLayoutSubviews() {
        
        if ui.displayLabel.text != nil {
            ui.deleteButton.isEnabled = true
        } else {
            ui.deleteButton.isEnabled = false
        }
    }
}

