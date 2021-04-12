//
//  LoginUITest.swift
//  SwiftLoginAppUITests
//
//  Created by HungNV on 4/9/21.
//  Copyright © 2021 NIFTY Corporation. All rights reserved.
//

import XCTest

class LoginUITest: XCTestCase {

    var app: XCUIApplication!
    var tfUsername: XCUIElement!
    var tfPassword: XCUIElement!
    var btnLogin: XCUIElement!
    var btnSignUp: XCUIElement!
    let msgValidate = "未入力の項目があります"
    
    // MARK: - Setup for UI Test
    override func setUp() {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app = XCUIApplication()
        tfUsername = app.textFields["tfUsername"]
        tfPassword = app.secureTextFields["tfPassword"]
        btnLogin = app.buttons["btnLogin"]
        btnSignUp = app.buttons["btnSignUp"]
    }
    
    func testLoginScreen() throws {
        app.launch()
        XCTAssert(app.staticTexts["Login"].exists)
        XCTAssert(tfUsername.exists)
        XCTAssert(tfPassword.exists)
        XCTAssert(btnLogin.exists)
        XCTAssert(btnSignUp.exists)
    }
    
    func testEmptyUsername() throws {
        app.launch()
        tfUsername.tap()
        tfUsername.typeText("")
        tfPassword.tap()
        tfPassword.typeText("123456")
        btnLogin.tap()
        XCTAssert(app.staticTexts[msgValidate].exists)
    }
    
    func testEmptyPassword() throws {
        app.launch()
        tfUsername.tap()
        tfUsername.typeText("Hoge")
        tfPassword.tap()
        tfPassword.typeText("")
        btnLogin.tap()
        XCTAssert(app.staticTexts[msgValidate].exists)
    }
    
    func testOpenSignUp() throws {
        app.launch()
        btnSignUp.tap()
        XCTAssert(app.staticTexts["Sign Up"].exists)
    }
    
    func testLoginSuccess() throws {
        app.launch()
        tfUsername.tap()
        tfUsername.typeText("Hoge")
        tfPassword.tap()
        tfPassword.typeText("123456")
        btnLogin.tap()
        XCTAssertTrue(app.staticTexts["SwiftLoginApp"].waitForExistence(timeout: 10))
    }
    
    func testLoginFail() throws {
        app.launch()
        tfUsername.tap()
        tfUsername.typeText("test")
        tfPassword.tap()
        tfPassword.typeText("123456")
        btnLogin.tap()
        
        let failPredicate = NSPredicate(format: "label BEGINSWITH 'ログインに失敗しました:'")
        let lblError = app.staticTexts.element(matching: failPredicate)
        if lblError.waitForExistence(timeout: 10) {
            XCTAssert(lblError.exists)
        }
    }
}
