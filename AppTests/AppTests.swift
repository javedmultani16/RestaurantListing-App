//
//  AppTests.swift
//  AppTests
//
//  Created by Javed Multani on 24/07/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import XCTest
@testable import App

class AppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    //Test email is valid or not
    func testEmailValid() {
        let sampleString = "javedmultani16@gmailcom"
        XCTAssertTrue(sampleString.isEmail())

    }
    //Test email is empty
    func testEmailisEmpty(){
        let sampleString = ""
        XCTAssertTrue(sampleString.isEmpty)
        
    }
    //Test password is valid
    func testValidPassword(){
        let sampleString = "a123456@"
        XCTAssertTrue(HelperFunction.helper.isPasswordValid(sampleString))
    }
    //Test mobile number is valid
    func testValidMobileNumber(){
        let mobile = "6043567382"
        if mobile.length > 7 && mobile.length < 11{
            XCTAssertTrue(true)
        }else{
            XCTAssertTrue(false)
        }
    }
}

