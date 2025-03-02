//
//  VideoPlayerView.swift
//  NasaObserver
//
//  Created by Guilherme Teixeira de Mello on 28/02/2025.
//

import SwiftUI

struct VideoPlayerView: View {
    let apod: APOD
    let isDetailView: Bool
    let onToggleFavorite: () -> Void
    
    var isIpad: Bool = Deviceidentifier.shared.isIpad()
    
    var body: some View {
        VStack {
            if let videoURL = apod.videoURL {
                WebView(url: videoURL)
                    .frame(height: isIpad ? Constants.frameHeightForViewIpad : Constants.frameHeightForView)
            } else {
                Text("No valid video URL.")
                    .frame(height: Constants.frameHeightForView)
            }
            if !isDetailView {
                HStack {
                    Button {
                        onToggleFavorite()
                        HapticManager.shared.playLikeButtonHaptic()
                    } label: {
                        HStack {
                            Image(systemName: apod.isFavorited ? "heart.fill" : "heart")
                                .font(.title3)
                                .scaleEffect(apod.isFavorited ? 1.3 : 1.0)
                                .animation(.spring(duration: 0.3, bounce: 0.6, blendDuration: 0.3), value: apod.isFavorited)
                                .tint(.red)
                                .padding(.leading, 5)
                            Text("Like")
                                .font(.body)
                                .tint(.primary)
                        }
                    }
                    Spacer()
                    Text(DateFormatterHelper.shared.displayDate(from: apod.date))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 8)
                .padding(.horizontal, 16)
            }
        }
    }
}
