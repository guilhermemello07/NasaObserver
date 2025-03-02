//
//  ImageCache.swift
//  NasaObserver
//
//  Created by Guilherme Teixeira de Mello on 28/02/2025.
//

import SwiftUI


final class ImageCache {
    
    private static var cache: [URL: Image] = [:]
    
    static subscript(url: URL) -> Image? {
        get {
            ImageCache.cache[url]
        }
        set {
            ImageCache.cache[url] = newValue
        }
    }
}
