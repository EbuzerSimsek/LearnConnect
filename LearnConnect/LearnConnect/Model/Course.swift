//
//  Model.swift
//  LearnConnect
//
//  Created by Ebuzer Şimşek on 22.11.2024.
//

import Foundation

struct Course {
    let id: String
    let title: String
    let description: String
    var videos: [CourseVideo]
    var category: String
    var image: String
    var isFavorite: Bool
}


extension Course {
    static func mockCourses() -> [Course] {
        return [
            Course(id: "course_1", title: "Lise Matematiği", description: "Temel matematik konuları", videos: [
                CourseVideo(id: "video_1_1", number: "1", title: "Sayılar ve İşlemler", description: "Tam sayılar ve rasyonel sayılar", videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4")!, duration: 0.47, progress: 0.23),
                CourseVideo(id: "video_1_2", number: "2", title: "Cebir", description: "Denklemler ve eşitsizlikler", videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4")!, duration: 0.47, progress: 0.23),
                CourseVideo(id: "video_1_3", number: "3", title: "Geometri", description: "Temel geometrik şekiller", videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4")!, duration: 1.00, progress: 0.45),
                CourseVideo(id: "video_1_4", number: "4", title: "Trigonometri", description: "Trigonometrik fonksiyonlar", videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4")!, duration: 1.00, progress: 0.45),
                CourseVideo(id: "video_1_5", number: "5", title: "Analitik Geometri", description: "Koordinat sisteminde geometri", videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4")!, duration: 1.00, progress: 0.45),
                CourseVideo(id: "video_1_6", number: "6", title: "Olasılık", description: "Temel olasılık hesaplamaları", videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4")!, duration: 1.00, progress: 0.45)
            ], category: "Mat", image: "math", isFavorite: false),
            Course(id: "course_2", title: "Lise Fiziği", description: "Temel fizik konuları", videos: [
                CourseVideo(id: "video_2_1", number: "1", title: "Mekanik", description: "Hareket ve kuvvet", videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4")!, duration: 1.00, progress: 0.45),
                CourseVideo(id: "video_2_2", number: "2", title: "Enerji", description: "Enerji türleri ve korunumu", videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4")!, duration: 1.00, progress: 0.45),
                CourseVideo(id: "video_2_3", number: "3", title: "Elektrik", description: "Elektrik akımı ve devreler", videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4")!, duration: 1.00, progress: 0.45),
                CourseVideo(id: "video_2_4", number: "4", title: "Isı ve Sıcaklık", description: "Termodinamik temelleri", videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4")!, duration: 1.00, progress: 0.45),
                CourseVideo(id: "video_2_5", number: "5", title: "Optik", description: "Işık ve görme", videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4")!, duration: 1.00, progress: 0.45),
                CourseVideo(id: "video_2_6", number: "6", title: "Modern Fizik", description: "Kuantum ve görelilik", videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4")!, duration: 1.00, progress: 0.45)
            ], category: "Fizik", image: "physics", isFavorite: false),
            Course(id: "course_3", title: "Lise Kimyası", description: "Temel kimya konuları", videos: [
                CourseVideo(id: "video_3_1", number: "1", title: "Atom Yapısı", description: "Atomun temel bileşenleri", videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4")!, duration: 1.00, progress: 0.45),
                CourseVideo(id: "video_3_2", number: "2", title: "Periyodik Tablo", description: "Elementlerin sınıflandırılması", videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4")!, duration: 1.00, progress: 0.45),
                CourseVideo(id: "video_3_3", number: "3", title: "Kimyasal Bağlar", description: "Molekül oluşumu", videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4")!, duration: 1.00, progress: 0.45),
                CourseVideo(id: "video_3_4", number: "4", title: "Asitler ve Bazlar", description: "pH ve nötrelleşme", videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4")!, duration: 1.00, progress: 0.45),
                CourseVideo(id: "video_3_5", number: "5", title: "Reaksiyon Türleri", description: "Kimyasal reaksiyonlar", videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4")!, duration: 1.00, progress: 0.45),
                CourseVideo(id: "video_3_6", number: "6", title: "Organik Kimya", description: "Karbon bileşikleri", videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4")!, duration: 1.00, progress: 0.45)
            ], category: "Kimya", image: "chemistry", isFavorite: false)
        ]
    }
}
extension User {
    static func mockUser() -> User {
        return User(
            id: UUID(),
            username: "kullanici123",
            email: "kullanici@ornek.com",
            enrolledCourses: [
                Course.mockCourses()[0],
                Course.mockCourses()[1]
            ]
        )
    }
}

