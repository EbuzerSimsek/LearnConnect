//
//  VideoPlayerView.swift
//  LearnConnect
//
//  Created by Ebuzer Şimşek on 23.11.2024.
//

import SwiftUI
import AVKit
import FirebaseFirestore
import FirebaseAuth

struct VideoPlayerView: View {
    @State private var player = AVPlayer()
    @Environment(\.dismiss) var dismiss
    var url: String
    var videoID: String
    let db = Firestore.firestore()
    
    var userID: String {
        return Auth.auth().currentUser?.uid ?? "unknown_user"
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            VideoPlayer(player: player)
                .edgesIgnoringSafeArea(.all)
                .navigationBarBackButtonHidden()
                .onAppear {
                    let url = URL(string: url)!
                    player = AVPlayer(url: url)
                    player.play()
                    
                    // Kullanıcının en son izlediği zamanı alıyoruz
                    fetchLastWatchedTime { lastTime in
                        if let lastTime = lastTime {
                            let seekTime = CMTime(seconds: lastTime, preferredTimescale: 1)
                            player.seek(to: seekTime)
                        }
                    }
                }
                .onDisappear {
                    player.pause()
                    saveCurrentTime()
                }
            
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .clipShape(Circle())
            }
            .padding()
        }
    }
    
    func saveCurrentTime() {
        let currentTime = player.currentTime().seconds
        db.collection("users")
            .document(userID)
            .collection("watchedVideos")
            .document(videoID)
            .setData(["lastWatchedTime": currentTime], merge: true) { error in
                if let error = error {
                    print("Error saving current time: \(error.localizedDescription)")
                } else {
                    print("Current time saved successfully.")
                }
            }
    }
    
    func fetchLastWatchedTime(completion: @escaping (Double?) -> Void) {
        db.collection("users")
            .document(userID)  // Kullanıcının kendi ID'sinden alıyoruz
            .collection("watchedVideos")
            .document(videoID)
            .getDocument { snapshot, error in
                if let error = error {
                    print("Error fetching last watched time: \(error.localizedDescription)")
                    completion(nil)
                } else if let snapshot = snapshot, snapshot.exists, let data = snapshot.data(), let lastWatchedTime = data["lastWatchedTime"] as? Double {
                    completion(lastWatchedTime)
                } else {
                    completion(nil)
                }
            }
    }
}

#Preview {
    VideoPlayerView(
        url: "https://embed-ssl.wistia.com/deliveries/cc8402e8c16cc8f36d3f63bd29eb82f99f4b5f88/accudvh5jy.mp4",
        videoID: "video_123"
    )
}
