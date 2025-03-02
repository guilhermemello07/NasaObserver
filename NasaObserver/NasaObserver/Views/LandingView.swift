//
//  LandingView.swift
//  NasaObserver
//
//  Created by Guilherme Teixeira de Mello on 28/02/2025.
//

import SwiftUI

struct LandingView: View {
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Label("APOD by Date", systemImage: "calendar")
                }
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
        }
    }
}

#Preview {
    LandingView()
}
