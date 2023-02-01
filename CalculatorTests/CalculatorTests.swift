//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by AmirHossein EramAbadi on 1/29/23.
//

import XCTest
@testable import Calculator
final class CalculatorTests: XCTestCase {
    private var calculate: Calculator?
    override func setUpWithError() throws {
        calculate = Calculator()
    }

    override func tearDownWithError() throws {
        calculate = nil
    }
    func testExample() throws {
        XCTAssertEqual(calculate?.advancedCalculationShit(this: "1+1"), "2")
    }
    func testPerformanceExample() throws {
        measure {
        }
    }

}
