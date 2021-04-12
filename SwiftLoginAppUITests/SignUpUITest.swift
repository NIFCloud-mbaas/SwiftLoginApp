//
//  SignUpUITest.swift
//  SwiftLoginAppUITests
//
//  Created by HungNV on 4/9/21.
//  Copyright © 2021 NIFTY Corporation. All rights reserved.
//

import XCTest

class SignUpUITest: XCTestCase {

    var app: XCUIApplication!
    var tfUsername: XCUIElement!
    var tfPassword: XCUIElement!
    var tfConfirm: XCUIElement!
    var btnSignUp: XCUIElement!
    let msgValidate = "未入力の項目があります"
    let msgValiConfirm = "Passwordが一致しません"
    
    // MARK: - Setup for UI Test
    override func setUp() {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app = XCUIApplication()
        tfUsername = app.textFields["tfUsername"]
        tfPassword = app.secureTextFields["tfPassword"]
        tfConfirm = app.secureTextFields["tfConfirm"]
        btnSignUp = app.buttons["btnSignUp"]
    }
    
    func testSignUpScreen() throws {
        app.launch()
        btnSignUp.tap()
        XCTAssertTrue(app.staticTexts["Sign Up"].waitForExistence(timeout: 10))
        XCTAssert(tfUsername.exists)
        XCTAssert(tfPassword.exists)
        XCTAssert(tfConfirm.exists)
        XCTAssert(btnSignUp.exists)
    }
    
    func testEmptyUsername() throws {
        app.launch()
        btnSignUp.tap()
        tfUsername.tap()
        tfUsername.typeText("")
        tfPassword.tap()
        tfPassword.typeText("123456")
        tfConfirm.tap()
        tfConfirm.typeText("123456")
        btnSignUp.tap()
        XCTAssert(app.staticTexts[msgValidate].exists)
    }
    
    func testEmptyPassword() throws {
        app.launch()
        btnSignUp.tap()
        tfUsername.tap()
        tfUsername.typeText("Hoge")
        tfPassword.tap()
        tfPassword.typeText("")
        tfConfirm.tap()
        tfConfirm.typeText("123456")
        btnSignUp.tap()
        XCTAssert(app.staticTexts[msgValidate].exists)
    }
    
    func testEmptyConfirmPassword() throws {
        app.launch()
        btnSignUp.tap()
        tfUsername.tap()
        tfUsername.typeText("Hoge")
        tfPassword.tap()
        tfPassword.typeText("123456")
        tfConfirm.tap()
        tfConfirm.typeText("")
        btnSignUp.tap()
        XCTAssert(app.staticTexts[msgValidate].exists)
    }
    
    func testPasswordAndConfirmPassword() throws {
        app.launch()
        btnSignUp.tap()
        tfUsername.tap()
        tfUsername.typeText("Hoge")
        tfPassword.tap()
        tfPassword.typeText("123456")
        tfConfirm.tap()
        tfConfirm.typeText("456789")
        btnSignUp.tap()
        XCTAssert(app.staticTexts[msgValiConfirm].exists)
    }
    
    func testSignUpSuccess() throws {
        app.launch()
        btnSignUp.tap()
        tfUsername.tap()
        tfUsername.typeText("user_test1")
        tfPassword.tap()
        tfPassword.typeText("123456")
        tfConfirm.tap()
        tfConfirm.typeText("123456")
        btnSignUp.tap()
        XCTAssertTrue(app.staticTexts["SwiftLoginApp"].waitForExistence(timeout: 10))
    }
}
