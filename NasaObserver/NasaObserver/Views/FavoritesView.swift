//
//  FavoritesView.swift
//  NasaObserver
//
//  Created by Guilherme Teixeira de Mello on 28/02/2025.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject private var viewModel = FavoritesViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.favorites, id: \.id) { apod in
                    NavigationLink {
                        DetailsView(apod: apod)
                    } label: {
                        FavoritesCardView(apod: apod)
                    }
                    
                }
                .onDelete { offsets in
                    viewModel.deleteFavorites(at: offsets)
                    HapticManager.shared.playDeleteFeedbackHaptic()
                }
            }
            .navigationTitle("Favorites")
            .toolbar {
                EditButton()
            }
        }
        .onAppear {
            HapticManager.shared.playSelectButtonHaptic()
        }
    }
    

}

#Preview {
    FavoritesView()
}
