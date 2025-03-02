//
//  LastCachedImageManager.swift
//  NasaObserver
//
//  Created by Guilherme Teixeira de Mello on 01/03/2025.
//

import SwiftUI
import Combine

final class LastCachedImageManager: ObservableObject {
    static let shared = LastCachedImageManager()
    
    private init() { }
    
    @Published var image: Image? = nil
}
