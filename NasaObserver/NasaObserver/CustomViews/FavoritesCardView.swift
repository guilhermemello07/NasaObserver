//
//  FavoritesCardView.swift
//  NasaObserver
//
//  Created by Guilherme Teixeira de Mello on 01/03/2025.
//

import SwiftUI

struct FavoritesCardView: View {
    let apod: APOD
    
    var body: some View {
        HStack {
            if apod.mediaType == "image",
               let urlString = apod.hdurl,
               let url = URL(string: urlString) {
                CacheAsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .shadow(radius: 8)
                            .frame(width: Constants.imageWidthForCard,
                                   height: Constants.imageHeightForCard)
                            .clipShape(Circle())
                    case .failure(_):
                        FallbackImageView()
                    case .empty:
                        ProgressView()
                    @unknown default:
                        FallbackImageView()
                    }
                }
            } else if apod.mediaType == "video" {
                if let thumbnailString = apod.thumbnailUrl,
                   let thumbnailURL = URL(string: thumbnailString) {
                    CacheAsyncImage(url: thumbnailURL) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .shadow(radius: 8)
                                .frame(width: Constants.imageWidthForCard,
                                       height: Constants.imageHeightForCard)
                                .clipShape(Circle())
                        case .failure(_), .empty:
                            FallbackImageView()
                        @unknown default:
                            FallbackImageView()
                        }
                    }
                } else { //No thumbnail image to display show last cached image
                    FallbackImageView()
                }
            }
            
            VStack(alignment: .leading) {
                Text(apod.title)
                    .font(.headline)
                    .lineLimit(1)
                    .truncationMode(.tail)
                Text(DateFormatterHelper.shared.displayDate(from: apod.date))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
    

}

#Preview {
    FavoritesCardView(apod: APOD.sampleDataWithVideo)
}
