//
//  LogoutUITest.swift
//  SwiftLoginAppUITests
//
//  Created by HungNV on 4/12/21.
//  Copyright © 2021 NIFTY Corporation. All rights reserved.
//

import XCTest

class LogoutUITest: XCTestCase {

    var app: XCUIApplication!
    var tfUsername: XCUIElement!
    var tfPassword: XCUIElement!
    var btnLogin: XCUIElement!
    var btnLogout: XCUIElement!
    
    // MARK: - Setup for UI Test
    override func setUp() {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app = XCUIApplication()
        tfUsername = app.textFields["tfUsername"]
        tfPassword = app.secureTextFields["tfPassword"]
        btnLogin = app.buttons["btnLogin"]
        btnLogout = app.buttons["btnLogout"]
    }
    
    func testLoginSuccess() throws {
        app.launch()
        tfUsername.tap()
        tfUsername.typeText("Hoge")
        tfPassword.tap()
        tfPassword.typeText("123456")
        btnLogin.tap()
        XCTAssertTrue(app.staticTexts["SwiftLoginApp"].waitForExistence(timeout: 10))
        XCTAssert(btnLogout.exists)
        btnLogout.tap()
    }
}
