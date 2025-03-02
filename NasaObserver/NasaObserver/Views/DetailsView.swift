//
//  DetailsView.swift
//  NasaObserver
//
//  Created by Guilherme Teixeira de Mello on 01/03/2025.
//

import SwiftUI

struct DetailsView: View {
    let apod: APOD
    
    @State private var isExpanded = false
    
    var isIpad: Bool = Deviceidentifier.shared.isIpad()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if apod.mediaType == "image" {
                    if let url = apod.imageURL {
                        CacheAsyncImage(url: url) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .onLongPressGesture {
                                        isExpanded = true
                                    }
                            case .failure(_):
                                FallbackImageView()
                            case .empty:
                                ProgressView()
                            @unknown default:
                                FallbackImageView()
                            }
                        }
                    }
                } else if apod.mediaType == "video" {
                    VideoPlayerView(apod: apod, isDetailView: true ,onToggleFavorite: {
                        // Do nothing as I didn't include fav button here.
                    })
                    .frame(height: isIpad ? Constants.frameHeightForViewIpad : Constants.frameHeightForView)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(apod.title)
                        .font(.title.bold())
                    
                    Text(DateFormatterHelper.shared.displayDate(from: apod.date))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    Text(apod.explanation)
                        .font(.body)
                }
                .padding(.horizontal, 10)
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $isExpanded) {
            if let url = apod.imageURL {
                ExpandedImageView(url: url) {
                    isExpanded = false
                }
            }
        }
    }
}

#Preview {
    DetailsView(apod: APOD.sampleDataWithImage)
}
