//
//  ListView.swift
//  LearnConnect
//
//  Created by Ebuzer Şimşek on 23.11.2024.
//

import SwiftUI

struct ListRowView: View {
    var number: String
    var title: String
    var duration: String
    var playAction: () -> Void
    
    var body: some View {
        VStack(spacing: 15) {
            HStack(spacing: 16) {
                Text(number)
                    .foregroundStyle(.gray)
                    .font(.system(size: 24, weight: .medium))
                
                Button(action: {
                    playAction()  
                }) {
                    Circle()
                        .fill(Color.yellow)
                        .frame(width: 50, height: 50)
                        .overlay(
                            Image(systemName: "play.fill")
                                .foregroundStyle(.black)
                                .font(.system(size: 18))
                        )
                }
                
                Text(title)
                    .foregroundStyle(.white)
                    .font(.system(size: 20, weight: .medium))
                
                Spacer()
                
                Text(duration)
                    .foregroundStyle(.gray)
                    .font(.system(size: 18))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color(white: 0.15))
        )
    }
}

