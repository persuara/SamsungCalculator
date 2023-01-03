//
//  NUmbersLogic.swift
//  Calculator
//
//  Created by AmirHossein EramAbadi on 1/2/23.
//

import Foundation

protocol NumbersDelegate {
    func didNumbersTapped(_ viewController: ViewController, which tag: Int) -> Void
}
