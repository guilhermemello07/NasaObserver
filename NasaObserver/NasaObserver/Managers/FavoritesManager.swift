//
//  FavoritesManager.swift
//  NasaObserver
//
//  Created by Guilherme Teixeira de Mello on 28/02/2025.
//

import Foundation
import SwiftUI

class FavoritesManager: ObservableObject {
    @Published var favorites: [APOD] = []
    
    private let favoritesKey = Constants.favoritesAPODArrayKey
    
    static let shared = FavoritesManager()
    private init() { loadFavorites() }
    
    func addFavorite(_ apod: APOD) {
        if !favorites.contains(where: { $0.id == apod.id }) {
            favorites.insert(apod, at: 0)
            saveFavorites()
        }
    }
    
    func removeFavorite(_ apod: APOD) {
        favorites.removeAll { $0.id == apod.id }
        saveFavorites()
    }
    
    private func favoritesFileURL() -> URL? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(Constants.favoritesAPODFilePathComponent)
    }
    
    func loadFavorites() {
        guard let url = favoritesFileURL(),
              let data = try? Data(contentsOf: url),
              let favs = try? JSONDecoder().decode([APOD].self, from: data)
        else { return }
        favorites = favs
    }
    
    func saveFavorites() {
        guard let url = favoritesFileURL(),
              let data = try? JSONEncoder().encode(favorites)
        else { return }
        try? data.write(to: url)
    }
}
