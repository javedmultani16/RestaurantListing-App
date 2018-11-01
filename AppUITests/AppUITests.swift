//
//  AppUITests.swift
//  AppUITests
//
//  Created by Javed Multani on 24/07/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import XCTest

class AppUITests: XCTestCase {
         var app: XCUIApplication!
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    //Check Blank field validation
    func testForLoginScreen() {
        
        let app = XCUIApplication()
        app.textFields["Email"].tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.tap()
        app.secureTextFields["Password"].tap()
        app.buttons["LOGIN"].tap()
       
       
    }
}
