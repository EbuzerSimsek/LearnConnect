//
//  User.swift
//  LearnConnect
//
//  Created by Ebuzer Şimşek on 28.11.2024.
//

import Foundation

struct User {
    let id: UUID
    var username: String
    let email: String
    var enrolledCourses: [Course]
}
