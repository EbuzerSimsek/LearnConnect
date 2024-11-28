//
//  SwiftUIView.swift
//  LearnConnect
//
//  Created by Ebuzer Şimşek on 23.11.2024.
//

import SwiftUI
import AVKit
import FirebaseFirestore
import FirebaseAuth

struct CourseView: View {
    var selectedCourse: Course
    @State var player = AVPlayer()
    @Environment(\.dismiss) var dismiss
    @State var selectedVideo: CourseVideo?
    @State var hasAddedToFavorite = false
    @State private var isEnrolled = false
    @State private var enrollmentMessage: String?
    @State private var showEnrollmentAlert = false
    
    var body: some View {
        ZStack {
            Color.black
            VStack(alignment: .leading, spacing: 10) {
                Spacer()
                Spacer()
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.white)
                            .font(.title2)
                            .padding()
                    }
                }

                VStack(alignment: .leading) {
                    Text(selectedCourse.title)
                        .fontWeight(.semibold)
                        .font(.system(size: 45))
                        .foregroundStyle(.white)
                        .padding()
                    Text(selectedCourse.description)
                        .padding(.horizontal)
                        .foregroundStyle(.white)
                }.padding(.bottom)

                HStack {
                    Button(action: {
                        enrollInCourse()
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 30)
                                .foregroundStyle(isEnrolled ? .green : .yellow)
                                .frame(width: 300, height: 65)
                            Text(isEnrolled ? "Kayıtlısınız" : "Kaydol")
                                .bold()
                                .font(.title)
                                .foregroundStyle(.black)
                        }
                    })
                    .frame(maxWidth: .infinity)

                    Button(action: {
                        toggleFavoriteStatus(for: selectedCourse.id)
                    }, label: {
                        ZStack {
                            Circle()
                                .foregroundStyle(.yellow)
                                .frame(width: 65)
                            Image(systemName: hasAddedToFavorite ? "star.fill" : "star")
                                .font(.title2)
                                .foregroundStyle(.black)
                        }
                    })
                }

                List {
                    ForEach(selectedCourse.videos) { video in
                        Button(action: {
                            if isEnrolled {
                                self.selectedVideo = video
                            } else {
                                showEnrollmentAlert = true
                            }
                        }) {
                            ListRowView(
                                number: video.number,
                                title: video.title,
                                duration: String(video.duration),
                                playAction: {
                                    if isEnrolled {
                                        self.selectedVideo = video
                                    } else {
                                        showEnrollmentAlert = true
                                    }
                                }
                            )
                        }
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets())
                    }
                }
                .listStyle(.grouped)
                .listRowSpacing(15)
                .scrollContentBackground(.hidden)
            }
        }
        .ignoresSafeArea()
        .fullScreenCover(item: $selectedVideo) { video in
            VideoPlayerView(url: video.videoURL.absoluteString, videoID: video.id)
        }
        .onAppear {
            checkEnrollmentStatus()
            checkFavoriteStatus()
        }
        .alert(isPresented: $showEnrollmentAlert) {
            Alert(
                title: Text("İzlemek için kaydol."),
                message: Text("Videoları izleyebilmek için kursa kaydolmalısınız."),
                primaryButton: .default(Text("Kaydol")) {
                    enrollInCourse()
                },
                secondaryButton: .cancel()
            )
        }
    }

    private func checkEnrollmentStatus() {
        guard let userID = Auth.auth().currentUser?.uid else {
            enrollmentMessage = "Kullanıcı oturum açmamış."
            return
        }

        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userID)

        userRef.getDocument { documentSnapshot, error in
            if let error = error {
                enrollmentMessage = "Belge kontrolü sırasında hata: \(error.localizedDescription)"
                return
            }

            guard let document = documentSnapshot, document.exists,
                  let enrolledCourseIDs = document.get("enrolledCourses") as? [String] else {
                enrollmentMessage = "Kullanıcı herhangi bir kursa kayıtlı değil."
                return
            }

            let courseID = selectedCourse.id
            if enrolledCourseIDs.contains(courseID) {
                isEnrolled = true
            } else {
                isEnrolled = false
            }
        }
    }

    private func checkFavoriteStatus() {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User is not authenticated.")
            return
        }

        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userID)

        userRef.getDocument { documentSnapshot, error in
            if let error = error {
                print("Error checking user document: \(error.localizedDescription)")
                return
            }

            if let document = documentSnapshot, document.exists {
                let favoriteCourses = document.get("favorites") as? [String: Bool] ?? [:]
                hasAddedToFavorite = favoriteCourses[selectedCourse.id] ?? false
            } else {
                print("No user document found. Creating document...")
                createUserDocument(userID: userID)
            }
        }
    }
    
    private func createUserDocument(userID: String) {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userID)

        userRef.setData([
            "favorites": [:]
        ]) { error in
            if let error = error {
                print("Error creating user document: \(error.localizedDescription)")
            } else {
                print("User document created successfully.")
            }
        }
    }

    private func toggleFavoriteStatus(for courseID: String) {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User is not authenticated.")
            return
        }

        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userID)

        userRef.getDocument { documentSnapshot, error in
            if let error = error {
                print("Error checking user document: \(error.localizedDescription)")
                return
            }

            if let document = documentSnapshot, document.exists {
                var favorites = document.get("favorites") as? [String: Bool] ?? [:]

                favorites[courseID] = !(favorites[courseID] ?? false)

                userRef.updateData([
                    "favorites": favorites
                ]) { error in
                    if let error = error {
                        print("Error updating favorite status: \(error.localizedDescription)")
                    } else {
                        hasAddedToFavorite.toggle() // UI'yi güncelle
                        print("Favorite status updated successfully.")
                    }
                }
            } else {
                print("No user document found. Creating document...")
                createUserDocument(userID: userID)
            }
        }
    }

    private func enrollInCourse() {
        guard let userID = Auth.auth().currentUser?.uid else {
            enrollmentMessage = "Kullanıcı oturum açmamış."
            return
        }

        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userID)

        userRef.getDocument { documentSnapshot, error in
            if let error = error {
                enrollmentMessage = "Belge kontrolü sırasında hata: \(error.localizedDescription)"
                return
            }

            let courseID = selectedCourse.id

            if !(documentSnapshot?.exists ?? false) {
                userRef.setData(["enrolledCourses": [courseID]]) { error in
                    if let error = error {
                        enrollmentMessage = "Belge oluşturulamadı: \(error.localizedDescription)"
                    } else {
                        isEnrolled = true
                        enrollmentMessage = "Kurs başarıyla eklendi!"
                    }
                }
            } else {
                userRef.updateData([
                    "enrolledCourses": FieldValue.arrayUnion([courseID])
                ]) { error in
                    if let error = error {
                        enrollmentMessage = "Kurs eklenirken hata: \(error.localizedDescription)"
                    } else {
                        isEnrolled = true
                        enrollmentMessage = "Kurs başarıyla eklendi!"
                    }
                }
            }
        }
    }
}
#Preview {
    CourseView(selectedCourse: Course.mockCourses().first!, selectedVideo: Course.mockCourses().first!.videos.first!)
}
