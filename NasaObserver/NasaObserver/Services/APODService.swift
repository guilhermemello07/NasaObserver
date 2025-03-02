//
//  APODService.swift
//  NasaObserver
//
//  Created by Guilherme Teixeira de Mello on 28/02/2025.
//

import Foundation


class APODService {
    static let shared = APODService(session: URLSession.shared, apiKey: APIKeyProvider.nasaAPIKey)
    
    let session: URLSessionProtocol
    let apiKey: String
    
    private init(session: URLSessionProtocol, apiKey: String) {
        self.session = session
        self.apiKey = apiKey
    }

    func fetchAPOD(for date: Date) async throws -> APOD {
        let dateString = DateFormatterHelper.shared.formatDate(date)
        
        if let favorite = FavoritesManager.shared.favorites.first(where: { $0.date == dateString }) {
            return favorite
        }
        
        let urlString = "https://api.nasa.gov/planetary/apod?api_key=\(apiKey)&date=\(dateString)&thumbs=true"
        guard let url = URL(string: urlString) else {
            throw NObserverError.invalidUrl
        }
        
        let (data, response) = try await session.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NObserverError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(APOD.self, from: data)
        return result
    }
    
}
