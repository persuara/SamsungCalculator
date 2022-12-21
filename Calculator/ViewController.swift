//
//  ViewController.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 12/20/22.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var equalView: UIView = {
        let view: UIView = .init(frame: .zero)
        view.layer.cornerRadius = 40
        view.backgroundColor = UIColor(cgColor: CGColor(red: 197.0/255.0, green: 163.0/255.0, blue: 154.0/255.0, alpha: 1.0))
        return view
    }()
    
    lazy var dotView: UIView = {
        let view: UIView = .init(frame: .zero)
        view.layer.cornerRadius = 40
        view.backgroundColor = UIColor(cgColor: CGColor(red: 24.0/255.0, green: 23.0/255.0, blue: 23.0/255.0, alpha: 1.0))
        return view
    }()
    lazy var zeroView: UIView = {
        let view: UIView = .init(frame: .zero)
        view.layer.cornerRadius = 40
        view.backgroundColor = UIColor(cgColor: CGColor(red: 24.0/255.0, green: 23.0/255.0, blue: 23.0/255.0, alpha: 1.0))
        return view
    }()
    lazy var absoluteView: UIView = {
        let view: UIView = .init(frame: .zero)
        view.layer.cornerRadius = 40
        view.backgroundColor = UIColor(cgColor: CGColor(red: 24.0/255.0, green: 23.0/255.0, blue: 23.0/255.0, alpha: 1.0))
        return view
    }()
    lazy var plusView: UIView = {
        let view: UIView = .init(frame: .zero)
        view.layer.cornerRadius = 40
        view.backgroundColor = UIColor(cgColor: CGColor(red: 24.0/255.0, green: 23.0/255.0, blue: 23.0/255.0, alpha: 1.0))
        return view
    }()
    lazy var threeView: UIView = {
        let view: UIView = .init(frame: .zero)
        view.layer.cornerRadius = 40
        view.backgroundColor = UIColor(cgColor: CGColor(red: 24.0/255.0, green: 23.0/255.0, blue: 23.0/255.0, alpha: 1.0))
        return view
    }()
    lazy var twoView: UIView = {
        let view: UIView = .init(frame: .zero)
        view.layer.cornerRadius = 40
        view.backgroundColor = UIColor(cgColor: CGColor(red: 24.0/255.0, green: 23.0/255.0, blue: 23.0/255.0, alpha: 1.0))
        return view
    }()
    lazy var oneView: UIView = {
        let view: UIView = .init(frame: .zero)
        view.layer.cornerRadius = 40
        view.backgroundColor = UIColor(cgColor: CGColor(red: 24.0/255.0, green: 23.0/255.0, blue: 23.0/255.0, alpha: 1.0))
        return view
    }()
    lazy var minusView: UIView = {
        let view: UIView = .init(frame: .zero)
        view.layer.cornerRadius = 40
        view.backgroundColor = UIColor(cgColor: CGColor(red: 24.0/255.0, green: 23.0/255.0, blue: 23.0/255.0, alpha: 1.0))
        return view
    }()
    lazy var sixView: UIView = {
        let view: UIView = .init(frame: .zero)
        view.layer.cornerRadius = 40
        view.backgroundColor = UIColor(cgColor: CGColor(red: 24.0/255.0, green: 23.0/255.0, blue: 23.0/255.0, alpha: 1.0))
        return view
    }()
    lazy var fiveView: UIView = {
        let view: UIView = .init(frame: .zero)
        view.layer.cornerRadius = 40
        view.backgroundColor = UIColor(cgColor: CGColor(red: 24.0/255.0, green: 23.0/255.0, blue: 23.0/255.0, alpha: 1.0))
        return view
    }()
    lazy var fourView: UIView = {
        let view: UIView = .init(frame: .zero)
        view.layer.cornerRadius = 40
        view.backgroundColor = UIColor(cgColor: CGColor(red: 24.0/255.0, green: 23.0/255.0, blue: 23.0/255.0, alpha: 1.0))
        return view
    }()
    lazy var multiplicationView: UIView = {
        let view: UIView = .init(frame: .zero)
        view.layer.cornerRadius = 40
        view.backgroundColor = UIColor(cgColor: CGColor(red: 24.0/255.0, green: 23.0/255.0, blue: 23.0/255.0, alpha: 1.0))
        return view
    }()
    lazy var nineView: UIView = {
        let view: UIView = .init(frame: .zero)
        view.layer.cornerRadius = 40
        view.backgroundColor = UIColor(cgColor: CGColor(red: 24.0/255.0, green: 23.0/255.0, blue: 23.0/255.0, alpha: 1.0))
        return view
    }()
    lazy var eightView: UIView = {
        let view: UIView = .init(frame: .zero)
        view.layer.cornerRadius = 40
        view.backgroundColor = UIColor(cgColor: CGColor(red: 24.0/255.0, green: 23.0/255.0, blue: 23.0/255.0, alpha: 1.0))
        return view
    }()
    lazy var sevenView: UIView = {
        let view: UIView = .init(frame: .zero)
        view.layer.cornerRadius = 40
        view.backgroundColor = UIColor(cgColor: CGColor(red: 24.0/255.0, green: 23.0/255.0, blue: 23.0/255.0, alpha: 1.0))
        return view
    }()
    lazy var divisionView: UIView = {
        let view: UIView = .init(frame: .zero)
        view.layer.cornerRadius = 40
        view.backgroundColor = UIColor(cgColor: CGColor(red: 24.0/255.0, green: 23.0/255.0, blue: 23.0/255.0, alpha: 1.0))
        return view
    }()
    lazy var percentageView: UIView = {
        let view: UIView = .init(frame: .zero)
        view.layer.cornerRadius = 40
        view.backgroundColor = UIColor(cgColor: CGColor(red: 24.0/255.0, green: 23.0/255.0, blue: 23.0/255.0, alpha: 1.0))
        return view
    }()
    lazy var paranthesesView: UIView = {
        let view: UIView = .init(frame: .zero)
        view.layer.cornerRadius = 40
        view.backgroundColor = UIColor(cgColor: CGColor(red: 24.0/255.0, green: 23.0/255.0, blue: 23.0/255.0, alpha: 1.0))
        return view
    }()
    lazy var clearView: UIView = {
        let view: UIView = .init(frame: .zero)
        view.layer.cornerRadius = 40
        view.backgroundColor = UIColor(cgColor: CGColor(red: 24.0/255.0, green: 23.0/255.0, blue: 23.0/255.0, alpha: 1.0))
        return view
    }()
    lazy var straightView: UIView = {
        let view: UIView = .init(frame: .zero)
        view.layer.borderColor = CGColor(red: 24.0/255.0, green: 23.0/255.0, blue: 23.0/255.0, alpha: 1.0)
        view.layer.borderWidth = 2
        return view
    }()
    lazy var clockIcon: UIImageView = {
        let view: UIImageView = .init(frame: .zero)
        view.image = UIImage(systemName: "clock")
        view.tintColor = UIColor(cgColor: CGColor(red: 197.0/255.0, green: 163.0/255.0, blue: 154.0/255.0, alpha: 1.0))
        return view
    }()
    lazy var rulerIcon: UIImageView = {
        let view: UIImageView = .init(frame: .zero)
        view.image = UIImage(systemName: "ruler")
        view.tintColor = UIColor(cgColor: CGColor(red: 197.0/255.0, green: 163.0/255.0, blue: 154.0/255.0, alpha: 1.0))
        return view
    }()
    lazy var mathIcon: UIImageView = {
        let view: UIImageView = .init(frame: .zero)
        view.image = UIImage(systemName: "function")
        view.tintColor = UIColor(cgColor: CGColor(red: 197.0/255.0, green: 163.0/255.0, blue: 154.0/255.0, alpha: 1.0))
        return view
    }()
    
    lazy var deleteIcon: UIImageView = {
        let view: UIImageView = .init(frame: .zero)
        view.image = UIImage(systemName: "delete.left")
        view.tintColor = UIColor(cgColor: CGColor(red: 197.0/255.0, green: 163.0/255.0, blue: 154.0/255.0, alpha: 0.3))
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        view.addSubview(equalView)
        equalView.translatesAutoresizingMaskIntoConstraints = false
        equalView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        equalView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        equalView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        equalView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(dotView)
        dotView.translatesAutoresizingMaskIntoConstraints = false
        dotView.trailingAnchor.constraint(equalTo: equalView.leadingAnchor, constant: -15).isActive = true
        dotView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        dotView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        dotView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(zeroView)
        zeroView.translatesAutoresizingMaskIntoConstraints = false
        zeroView.trailingAnchor.constraint(equalTo: dotView.leadingAnchor, constant: -15).isActive = true
        zeroView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        zeroView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        zeroView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(absoluteView)
        absoluteView.translatesAutoresizingMaskIntoConstraints = false
        absoluteView.trailingAnchor.constraint(equalTo: zeroView.leadingAnchor, constant: -15).isActive = true
        absoluteView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        absoluteView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        absoluteView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(plusView)
        plusView.translatesAutoresizingMaskIntoConstraints = false
        plusView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        plusView.bottomAnchor.constraint(equalTo: equalView.topAnchor, constant: -15).isActive = true
        plusView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        plusView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(threeView)
        threeView.translatesAutoresizingMaskIntoConstraints = false
        threeView.trailingAnchor.constraint(equalTo: plusView.leadingAnchor, constant: -15).isActive = true
        threeView.bottomAnchor.constraint(equalTo: equalView.topAnchor, constant: -15).isActive = true
        threeView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        threeView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(twoView)
        twoView.translatesAutoresizingMaskIntoConstraints = false
        twoView.trailingAnchor.constraint(equalTo: threeView.leadingAnchor, constant: -15).isActive = true
        twoView.bottomAnchor.constraint(equalTo: equalView.topAnchor, constant: -15).isActive = true
        twoView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        twoView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(oneView)
        oneView.translatesAutoresizingMaskIntoConstraints = false
        oneView.trailingAnchor.constraint(equalTo: twoView.leadingAnchor, constant: -15).isActive = true
        oneView.bottomAnchor.constraint(equalTo: equalView.topAnchor, constant: -15).isActive = true
        oneView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        oneView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(minusView)
        minusView.translatesAutoresizingMaskIntoConstraints = false
        minusView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        minusView.bottomAnchor.constraint(equalTo: plusView.topAnchor, constant: -15).isActive = true
        minusView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        minusView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(sixView)
        sixView.translatesAutoresizingMaskIntoConstraints = false
        sixView.trailingAnchor.constraint(equalTo: minusView.leadingAnchor, constant: -15).isActive = true
        sixView.bottomAnchor.constraint(equalTo: threeView.topAnchor, constant: -15).isActive = true
        sixView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        sixView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(fiveView)
        fiveView.translatesAutoresizingMaskIntoConstraints = false
        fiveView.trailingAnchor.constraint(equalTo: sixView.leadingAnchor, constant: -15).isActive = true
        fiveView.bottomAnchor.constraint(equalTo: twoView.topAnchor, constant: -15).isActive = true
        fiveView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        fiveView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(fourView)
        fourView.translatesAutoresizingMaskIntoConstraints = false
        fourView.trailingAnchor.constraint(equalTo: fiveView.leadingAnchor, constant: -15).isActive = true
        fourView.bottomAnchor.constraint(equalTo: oneView.topAnchor, constant: -15).isActive = true
        fourView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        fourView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(multiplicationView)
        multiplicationView.translatesAutoresizingMaskIntoConstraints = false
        multiplicationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        multiplicationView.bottomAnchor.constraint(equalTo: minusView.topAnchor, constant: -15).isActive = true
        multiplicationView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        multiplicationView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(nineView)
        nineView.translatesAutoresizingMaskIntoConstraints = false
        nineView.trailingAnchor.constraint(equalTo: multiplicationView.leadingAnchor, constant: -15).isActive = true
        nineView.bottomAnchor.constraint(equalTo: sixView.topAnchor, constant: -15).isActive = true
        nineView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        nineView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(eightView)
        eightView.translatesAutoresizingMaskIntoConstraints = false
        eightView.trailingAnchor.constraint(equalTo: nineView.leadingAnchor, constant: -15).isActive = true
        eightView.bottomAnchor.constraint(equalTo: fiveView.topAnchor, constant: -15).isActive = true
        eightView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        eightView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(sevenView)
        sevenView.translatesAutoresizingMaskIntoConstraints = false
        sevenView.trailingAnchor.constraint(equalTo: eightView.leadingAnchor, constant: -15).isActive = true
        sevenView.bottomAnchor.constraint(equalTo: fourView.topAnchor, constant: -15).isActive = true
        sevenView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        sevenView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(divisionView)
        divisionView.translatesAutoresizingMaskIntoConstraints = false
        divisionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        divisionView.bottomAnchor.constraint(equalTo: multiplicationView.topAnchor, constant: -15).isActive = true
        divisionView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        divisionView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(percentageView)
        percentageView.translatesAutoresizingMaskIntoConstraints = false
        percentageView.trailingAnchor.constraint(equalTo: divisionView.leadingAnchor, constant: -15).isActive = true
        percentageView.bottomAnchor.constraint(equalTo: nineView.topAnchor, constant: -15).isActive = true
        percentageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        percentageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(paranthesesView)
        paranthesesView.translatesAutoresizingMaskIntoConstraints = false
        paranthesesView.trailingAnchor.constraint(equalTo: percentageView.leadingAnchor, constant: -15).isActive = true
        paranthesesView.bottomAnchor.constraint(equalTo: eightView.topAnchor, constant: -15).isActive = true
        paranthesesView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        paranthesesView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(clearView)
        clearView.translatesAutoresizingMaskIntoConstraints = false
        clearView.trailingAnchor.constraint(equalTo: paranthesesView.leadingAnchor, constant: -15).isActive = true
        clearView.bottomAnchor.constraint(equalTo: sevenView.topAnchor, constant: -15).isActive = true
        clearView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        clearView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(straightView)
        straightView.translatesAutoresizingMaskIntoConstraints = false
        straightView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        straightView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        straightView.bottomAnchor.constraint(equalTo: clearView.topAnchor, constant: -20).isActive = true
        straightView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        view.addSubview(clockIcon)
        clockIcon.translatesAutoresizingMaskIntoConstraints = false
        clockIcon.bottomAnchor.constraint(equalTo: straightView.topAnchor, constant: -30).isActive = true
        clockIcon.heightAnchor.constraint(equalToConstant: 25).isActive = true
        clockIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        clockIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        clockIcon.transform = CGAffineTransform.init(rotationAngle: 1.6)
        
        view.addSubview(rulerIcon)
        rulerIcon.translatesAutoresizingMaskIntoConstraints = false
        rulerIcon.bottomAnchor.constraint(equalTo: straightView.topAnchor, constant: -30).isActive = true
        rulerIcon.heightAnchor.constraint(equalToConstant: 25).isActive = true
        rulerIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        rulerIcon.leadingAnchor.constraint(equalTo: clockIcon.leadingAnchor, constant: 60).isActive = true
        
        view.addSubview(mathIcon)
        mathIcon.translatesAutoresizingMaskIntoConstraints = false
        mathIcon.bottomAnchor.constraint(equalTo: straightView.topAnchor, constant: -30).isActive = true
        mathIcon.heightAnchor.constraint(equalToConstant: 25).isActive = true
        mathIcon.widthAnchor.constraint(equalToConstant: 35).isActive = true
        mathIcon.leadingAnchor.constraint(equalTo: rulerIcon.leadingAnchor, constant: 60).isActive = true
        
        view.addSubview(deleteIcon)
        deleteIcon.translatesAutoresizingMaskIntoConstraints = false
        deleteIcon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        deleteIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        deleteIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        deleteIcon.bottomAnchor.constraint(equalTo: straightView.topAnchor, constant: -30).isActive = true
    }
    
    
}


