//
//  MainViewModel.swift
//  NasaObserver
//
//  Created by Guilherme Teixeira de Mello on 28/02/2025.
//

import Foundation
import SwiftUI
import Combine


@MainActor
class MainViewModel: ObservableObject {
    @Published var apod: APOD?
    @Published var error: Error?
    @Published var isLoading: Bool = false
    @Published var date: Date = Date.now
    
    private var cancellables = Set<AnyCancellable>()
    
    init(session: URLSessionProtocol = URLSession.shared) {
        subscribeToFavoritesChanges()
        Task { await loadData() }
    }
    
    private func subscribeToFavoritesChanges() {
        FavoritesManager.shared.$favorites
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.updateFavoriteStatus()
            }
            .store(in: &cancellables)
    }
    
    
     private func updateFavoriteStatus() {
         guard var currentAPOD = apod else { return }
         let isFavorited = FavoritesManager.shared.favorites.contains(where: { $0.date == currentAPOD.date })
         if currentAPOD.isFavorited != isFavorited {
             currentAPOD.isFavorited = isFavorited
             self.apod = currentAPOD
         }
     }
    
    func loadData() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let fetchedAPOD = try await APODService.shared.fetchAPOD(for: date)
            let dateString = DateFormatterHelper.shared.formatDate(date)
            var updatedAPOD = fetchedAPOD
            
            if FavoritesManager.shared.favorites.contains(where: { $0.date.trimmingCharacters(in: .whitespacesAndNewlines) == dateString }) {
                updatedAPOD.isFavorited = true
            } else {
                updatedAPOD.isFavorited = false
            }
            self.apod = updatedAPOD
        } catch {
            // Not showing error to the user...
            self.error = error
        }
    }
    
    func toggleAPODFavorite() {
        guard var apod = apod else { return }
        apod.isFavorited.toggle()
        self.apod = apod
        
        if apod.isFavorited {
            FavoritesManager.shared.addFavorite(apod)
        } else {
            FavoritesManager.shared.removeFavorite(apod)
        }
    }
    
    func assignNewDate(_ date: Date) async {
        self.date = date
        await loadData()
    }
}
