//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by AmirHossein EramAbadi on 1/29/23.
//

import XCTest
@testable import Calculator
final class CalculatorTests: XCTestCase {
    
    private var calculate: Calculator!
    
    override func setUpWithError() throws {
        calculate = Calculator()
    }

    override func tearDownWithError() throws {
        calculate = nil
    }

    func testExample() throws {
        var hi: String = "1×(3–6%×(6+3))"
        XCTAssertEqual(calculate.advancedCalculationShit(this: hi), "2.46")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
