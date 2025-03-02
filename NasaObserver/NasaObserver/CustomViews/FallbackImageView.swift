//
//  FallbackImageView.swift
//  NasaObserver
//
//  Created by Guilherme Teixeira de Mello on 01/03/2025.
//

import SwiftUI

struct FallbackImageView: View {
    @ObservedObject var fallbackManager = LastCachedImageManager.shared
    
    var body: some View {
        if let fallback = fallbackManager.image {
            fallback
                .resizable()
                .frame(width: Constants.imageWidthForCard,
                       height: Constants.imageHeightForCard)
                .shadow(radius: 8)
                .clipShape(Circle())
        } else {
            Image(systemName: "photo.circle")
                .resizable()
                .frame(width: Constants.imageWidthForCard,
                       height: Constants.imageHeightForCard)
                .clipShape(Circle())
                .foregroundColor(.blue)
        }
    }
}

#Preview {
    FallbackImageView()
}
