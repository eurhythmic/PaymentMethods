//
//  PaymentMethodsTests.swift
//  PaymentMethodsTests
//
//  Created by RnD on 5/11/21.
//

import XCTest
@testable import PaymentMethods

class PaymentMethodsTests: XCTestCase {

    override func setUpWithError() throws {
        super.setUp()
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }

    func testPaymentMethodsRetrieved() throws {
        // Given
        let viewModel = PaymentsViewModel()
        
        let exp = expectation(description: "Retrieve payment methods from JSON")
        
        // When
        viewModel.loadPayments()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            XCTAssertEqual(viewModel.results.value.count, 17, "payment methods is not 17")

            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3)
    }

}
