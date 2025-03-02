//
//  FavoritesViewModel.swift
//  NasaObserver
//
//  Created by Guilherme Teixeira de Mello on 28/02/2025.
//

import Foundation
import Combine

@MainActor
class FavoritesViewModel: ObservableObject {
    @Published var favorites: [APOD] = []
    
    private var favoritesManager = FavoritesManager.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // Initialize with the current favorites from the manager.
        favorites = favoritesManager.favorites
        
        // Subscribe to changes in FavoritesManager.
        favoritesManager.$favorites
            .receive(on: RunLoop.main)
            .assign(to: \.favorites, on: self)
            .store(in: &cancellables)
    }
    
    func deleteFavorites(at offsets: IndexSet) {
        // For each deletion offset, remove the corresponding favorite
        offsets.forEach { index in
            let apod = self.favorites[index]
            FavoritesManager.shared.removeFavorite(apod)
        }
    }
}
