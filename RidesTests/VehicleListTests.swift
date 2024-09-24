//
//  VehicleListTests.swift
//  RidesTests
//
//  Created by Radhia MIGHRI on 23/9/2024.
//

import XCTest
@testable import Rides

final class VehicleListTests: XCTestCase {
    
    var viewController: VehicleListViewController!
    
    override func setUp() {
        super.setUp()
        // Load the view controller from storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "VehicleListViewController") as? VehicleListViewController
        viewController.loadViewIfNeeded() // Ensure the view is loaded
        
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    // MARK: - Test Cases
    
    // Test for valid input (no alert should be shown)
    func testValidInputDoesNotShowAlert() {
        viewController.inputTextField.text = "50"
        viewController.fetchButtonTapped(UIButton())
        
        // Ensure no alert is presented
        XCTAssertNil(viewController.presentedViewController, "No alert should be presented for valid input.")
    }
        
    // Test for input less than 0 (alert should be shown)
    func testInputLessThanZeroShowsAlertx() {
        viewController.inputTextField.text = "-1"
        viewController.fetchButtonTapped(UIButton())
        
        XCTAssertTrue(viewController.isAlertPresented, "Alert should be presented for input less than 0")
        XCTAssertEqual(viewController.alert.message, "Number must be between 0 and 100.")
    }
    
    // Test for input greater than 100 (alert should be shown)
    func testInputGreaterThanHundredShowsAlert() {
        viewController.inputTextField.text = "101"
        viewController.fetchButtonTapped(UIButton())
        
        XCTAssertTrue(viewController.isAlertPresented, "Alert should be presented for input greater than 100.")
        XCTAssertEqual(viewController.alert.message, "Number must be between 0 and 100.")
        
    }
    
    // Test for non-numeric input (alert should be shown)
    func testNonNumericInputShowsAlert() {
        viewController.inputTextField.text = "abc"
        viewController.fetchButtonTapped(UIButton())
        
        XCTAssertTrue(viewController.isAlertPresented, "Alert should be presented for non-numeric input.")
        XCTAssertEqual(viewController.alert.message, "Please enter a valid number.")
    }
    
    // Test for empty input (alert should be shown)
    func testEmptyInputShowsAlert() {
        viewController.inputTextField.text = ""
        viewController.fetchButtonTapped(UIButton())
        
        XCTAssertTrue(viewController.isAlertPresented, "Alert should be presented for empty input.")
        XCTAssertEqual(viewController.alert.message, "Please enter a valid number.")
    }
    
}
