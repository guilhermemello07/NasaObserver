//
//  NasaObserverApp.swift
//  NasaObserver
//
//  Created by Guilherme Teixeira de Mello on 28/02/2025.
//

import SwiftUI

@main
struct NasaObserverApp: App {
    var body: some Scene {
        WindowGroup {
            LandingView()
                .environmentObject(OrientationObserver())
        }
    }
}
