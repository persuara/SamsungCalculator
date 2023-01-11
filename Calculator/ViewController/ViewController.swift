//
//  ViewController.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 12/20/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    lazy var viewModel = ViewModel()
    lazy var ui = MainUI()
    lazy var pe = Print()
    lazy var leftover = Leftover()
    lazy var animate = Animation()
    lazy var errorSetting = ErrorSettings()
    lazy var lastElement = Validation()
    //    lazy var calculation = Calculation()
    var currentLabel: ErrorMessage?
    
    var historyArray =  [String]()
    var distanceFromButton: Int = 0
    
    static var temp: String?
    static var resultSubstitude: String?
    

    
    
    

    
    lazy var deleteIcon: UIButton = {
        let view: UIButton = .init(frame: .zero)
        view.setBackgroundImage(UIImage(systemName: "delete.left"), for: .normal)
        view.tintColor = UIColor(cgColor: CGColor(red: 197.0/255.0, green: 163.0/255.0, blue: 154.0/255.0, alpha: 1))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isEnabled = false
//        view.addTarget(self, action: #selector(addDeleteFunctionality), for: .touchUpInside)
        return view
    }()
    lazy var errorMessage: UILabel = {
        let view: UILabel = .init(frame: .zero)
        view.font = UIFont.init(name: "Ariel", size: 15)
        view.backgroundColor = .white.withAlphaComponent(0.3)
        view.textColor = .white
        view.textAlignment = .center
        view.alpha = 0
        view.layer.cornerRadius = 25
        view.adjustsFontSizeToFitWidth = true
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        ui.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ui)
        
        
        NSLayoutConstraint.activate([
            
            ui.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            ui.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            ui.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            ui.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    override func viewDidLayoutSubviews() {
        
        if ui.displayLabel.text != nil {
            ui.deleteButton.isEnabled = true
        } else {
            ui.deleteButton.isEnabled = false
        }
    }

    func addButtonIconStack(_ number: Int, from array: [ModelButton]) -> Void {
        for i in 0...number {
            let btn: UIButton = .init(frame: .zero)
            
            btn.setImage(UIImage(systemName: array[i].title), for: .normal)
            btn.tintColor = UIColor(cgColor: CGColor(red: array[i].titleColor[0]/255.0, green: array[i].titleColor[1]/255.0, blue: array[i].titleColor[2]/255.0, alpha: 1.0))
//            ui.rowIconsStackView.addArrangedSubview(btn)
            if i == 0 {
                btn.transform = CGAffineTransform.init(rotationAngle: 1.6)
                
            }
        }
    }
  
//    @objc func addDeleteFunctionality() -> Void {
//        isDeleteButtonTapped = true
//        var s: String?
//        var r: String?
//        guard let text = displayLabel.text else { return  deleteIcon.isEnabled = false }
//        s = text
//        r = ViewController.temp
//        if s?.isEmpty == false && r?.isEmpty == false {
//            let absDiff = abs(leftover.diffInParanthesesCount(r!))
//            if isExtraParanthesesNeeded {
//                print("Extra delete needed!x")
//                for _ in 0...absDiff{
//                    r!.removeLast()
//                }
//                isExtraParanthesesNeeded = !isExtraParanthesesNeeded
//            } else {
//                print("Normal Delete")
//                s!.removeLast()
//                r!.removeLast()
//                displayLabel.text = s
//                ViewController.temp = r
//                ViewController.resultSubstitude = r
//                print("Inside Delete Button: Temp =  \(ViewController.resultSubstitude ?? "")")
//            }
//        } else {
//            displayLabel.text = nil
//            deleteIcon.isEnabled = false
//            resultLabel.isHidden = true
//
//        }
//        //        isDeleteButtonTapped = !isDeleteButtonTapped
//    }
    
    //    ----------- Error Messages Config
    
    public func showErrorMessage(_ modelText: ErrorMessage) {
        errorMessage.alpha = 1
        self.errorMessage.text = modelText.rawValue
        UIView.animate(withDuration: 2.5, animations: { () -> Void in
            self.errorMessage.alpha = 0
        })
    }
}

