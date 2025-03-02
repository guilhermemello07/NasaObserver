//
//  ExpandedImageView.swift
//  NasaObserver
//
//  Created by Guilherme Teixeira de Mello on 28/02/2025.
//
import SwiftUI


struct ExpandedImageView: View {
    let url: URL
    let onDismiss: () -> Void
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            CacheAsyncImage(url: url) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black)
                        .ignoresSafeArea()
                case .failure(_):
                    FallbackImageView()
                case .empty:
                    ProgressView() 
                        .tint(.white)
                @unknown default:
                    FallbackImageView()
                }
            }
            
            Button {
                onDismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
            }
        }
        .background(Color.black.ignoresSafeArea())
    }
}
