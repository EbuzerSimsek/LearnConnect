//
//  MainViewModel.swift
//  LearnConnect
//
//  Created by Ebuzer Şimşek on 28.11.2024.
//

import Foundation

class MainViewModel {
    var courses: [Course] = []
    var filteredCourses: [Course] = []
    
    
    var onCoursesUpdated: (() -> Void)?
    
    init() {
        loadCourses()
    }
    
    func loadCourses() {
        
        courses = Course.mockCourses()
        filteredCourses = courses
        onCoursesUpdated?() 
    }
    
    func filterCourses(by category: String) {
        guard category != "All" else {
            filteredCourses = courses
            onCoursesUpdated?()
            return
        }
        
        filteredCourses = courses.filter { $0.category == category }
        onCoursesUpdated?()
    }
    
    func course(at index: Int) -> Course {
        return filteredCourses[index]
    }
    
    var numberOfCourses: Int {
        return filteredCourses.count
    }
}
