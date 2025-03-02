//
//  APIKeyProvider.swift
//  NasaObserver
//
//  Created by Guilherme Teixeira de Mello on 28/02/2025.
//

import Foundation

struct APIKeyProvider {
    static var nasaAPIKey: String {
        Bundle.main.object(forInfoDictionaryKey: Constants.infoDictionaryKeyForAPIKey) as? String ?? ""
    }
}
