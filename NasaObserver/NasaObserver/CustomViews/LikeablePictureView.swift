//
//  LikeablePictureView.swift
//  NasaObserver
//
//  Created by Guilherme Teixeira de Mello on 28/02/2025.
//

import SwiftUI

struct LikeablePictureView: View {
    @ObservedObject var viewModel: MainViewModel
    
    @State private var isExpanded = false
    
    let isIpad: Bool = Deviceidentifier.shared.isIpad()
    
    var body: some View {
        VStack {
            if let apod = viewModel.apod {
                if let imageURL = apod.imageURL {
                    CacheAsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .frame(height: isIpad ? Constants.frameHeightForViewIpad : Constants.frameHeightForView)
                                .scaledToFill()
                                .onTapGesture(count: 2) {
                                    viewModel.toggleAPODFavorite()
                                    HapticManager.shared.playLikeButtonHaptic()
                                }
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
                } else {
                    FallbackImageView()
                }
                
                HStack {
                    Button {
                        viewModel.toggleAPODFavorite()
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
        .fullScreenCover(isPresented: $isExpanded) {
            if let url = viewModel.apod?.imageURL {
                ExpandedImageView(url: url, onDismiss: { isExpanded = false })
            }
        }
    }
}

