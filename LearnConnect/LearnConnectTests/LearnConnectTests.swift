//
//  LearnConnectTests.swift
//  LearnConnectTests
//
//  Created by Ebuzer Şimşek on 28.11.2024.
//

import XCTest
@testable import LearnConnect

class YourViewModelTests: XCTestCase {

    var viewModel: MainViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = MainViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testLoadCourses() {
        viewModel.loadCourses()

        XCTAssertNotNil(viewModel.courses, "Courses should not be nil")
        XCTAssertTrue(viewModel.courses.count > 0, "Courses should not be empty")

        XCTAssertNotNil(viewModel.filteredCourses, "Filtered courses should not be nil")
        XCTAssertTrue(viewModel.filteredCourses.count > 0, "Filtered courses should not be empty")
    }

    func testCoursesCount() {
        viewModel.loadCourses()

        XCTAssertGreaterThan(viewModel.courses.count, 0, "There should be at least one course")
    }

    func testFilteredCourses() {
        viewModel.loadCourses()

        XCTAssertEqual(viewModel.filteredCourses.count, viewModel.courses.count, "Filtered courses should match the courses count")
    }
}
