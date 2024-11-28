//
//  AuthTest.swift
//  LearnConnectTests
//
//  Created by Ebuzer Şimşek on 28.11.2024.
//

import XCTest
@testable import LearnConnect

class DarkModeTests: XCTestCase {
    
    var viewModel: SettingsViewModel!

    override func setUp() {
        super.setUp()
        UserDefaults.standard.removeObject(forKey: "isDarkMode")
        viewModel = SettingsViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testToggleDarkModeOn() {
        XCTAssertFalse(viewModel.darkModeEnabled)

        viewModel.toggleDarkMode(isOn: true)

        XCTAssertTrue(viewModel.darkModeEnabled)

        let isDarkModeSaved = UserDefaults.standard.bool(forKey: "isDarkMode")
        XCTAssertTrue(isDarkModeSaved)
    }

    func testToggleDarkModeOff() {
        viewModel.toggleDarkMode(isOn: true)
        XCTAssertTrue(viewModel.darkModeEnabled)
        
        viewModel.toggleDarkMode(isOn: false)
        
        XCTAssertFalse(viewModel.darkModeEnabled)
        
        let isDarkModeSaved = UserDefaults.standard.bool(forKey: "isDarkMode")
        XCTAssertFalse(isDarkModeSaved)
    }
}
