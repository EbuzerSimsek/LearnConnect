//
//  CourseVideo.swift
//  LearnConnect
//
//  Created by Ebuzer Şimşek on 28.11.2024.
//

import Foundation

struct CourseVideo: Identifiable {
    let id: String
    let number: String
    let title: String
    let description: String
    let videoURL: URL
    var duration: Double
    var progress: Double
}
