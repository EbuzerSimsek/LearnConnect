//
//  VideoListViewModel.swift
//  LearnConnect
//
//  Created by Ebuzer Şimşek on 27.11.2024.
//

import Foundation
import SwiftUI
import FirebaseFirestore

class VideoListViewModel: ObservableObject {
    @Published var videos: [CourseVideo] = []
    private let db = Firestore.firestore()
    private let userID = "user_123" // Replace with actual user authentication
    
    init() {
        fetchVideosWithProgress()
    }
    
    func fetchVideosWithProgress() {
        // Replace this with your actual video data source
        let mockVideos = [
            ("1", "Fizik", "2.35", "https://example.com/physics.mp4", "video_physics"),
            ("2", "Kimya", "1.45", "https://example.com/chemistry.mp4", "video_chemistry")
        ]
        
        let group = DispatchGroup()
        var fetchedVideos: [CourseVideo] = []
        
        for (number, title, duration, url, videoID) in mockVideos {
            group.enter()
            
            fetchVideoProgress(videoID: videoID) { progress in
                let video = CourseVideo(
                    id: videoID,
                    number: number,
                    title: title, description: "", videoURL: URL(string: url)!,
                    duration: duration,
                    progress: progress
                )
                fetchedVideos.append(video)
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.videos = fetchedVideos
        }
    }
    
    func fetchVideoProgress(videoID: String, completion: @escaping (Double) -> Void) {
        db.collection("users")
            .document(userID)
            .collection("watchedVideos")
            .document(videoID)
            .getDocument { snapshot, error in
                if let error = error {
                    print("Error fetching video progress: \(error.localizedDescription)")
                    completion(0.0)
                    return
                }
                
                // Extract last watched time and total duration
                let data = snapshot?.data()
                let lastWatchedTime = data?["lastWatchedTime"] as? Double ?? 0.0
                let totalDuration = data?["totalDuration"] as? Double
                
                // Calculate progress
                if let totalDuration = totalDuration, totalDuration > 0 {
                    let progress = lastWatchedTime / totalDuration
                    completion(min(max(progress, 0.0), 1.0))
                } else {
                    completion(0.0)
                }
            }
    }
}
