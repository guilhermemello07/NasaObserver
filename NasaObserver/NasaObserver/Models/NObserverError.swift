//
//  NObserverError.swift
//  NasaObserver
//
//  Created by Guilherme Teixeira de Mello on 02/03/2025.
//

import Foundation

enum NObserverError: Error, LocalizedError {
    case invalidUrl
    case invalidResponse
    case invalidData
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "There was an error accessing the resource, please check your internet connection and try again."
        case .invalidResponse:
            return "There was an error with the server. Please try again later."
        case .invalidData:
            return "The data is invalid. Please try again later."
        case .unknown(let error):
            return error.localizedDescription
        }
    }

}
