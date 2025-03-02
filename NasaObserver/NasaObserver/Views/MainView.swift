//
//  MainView.swift
//  NasaObserver
//
//  Created by Guilherme Teixeira de Mello on 28/02/2025.
//

import SwiftUI
import AVKit

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    
    @State private var showCalendar: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    if let apod = viewModel.apod {
                        if apod.mediaType == "image" {
                            LikeablePictureView(viewModel: viewModel)
                        } else if apod.mediaType == "video" {
                            VideoPlayerView(apod: apod, isDetailView: false) {
                                viewModel.toggleAPODFavorite()
                            }
                        } else {
                            Text("Unsupported media type: \(apod.mediaType)")
                                .frame(height: Constants.frameHeightForView)
                        }
                        Divider()
                        VStack(alignment: .leading, spacing: 8) {
                            Text(apod.title)
                                .font(.title.bold())
                            Text(apod.explanation)
                                .font(.body)
                        }
                        .padding(.horizontal, 10)
                    }
                }
            }
            .sheet(isPresented: $showCalendar) {
                CalendarSheetView(
                    currentDate: viewModel.date
                ) { newDate in
                    Task { await viewModel.assignNewDate(newDate) }
                }
                .presentationDetents([.medium])
            }
            .navigationTitle("Nasa Observer")
            .toolbar {
                Button {
                    self.showCalendar.toggle()
                    HapticManager.shared.playSelectButtonHaptic()
                } label: {
                    Label("Calendar", systemImage: "calendar.badge.plus")
                }
            }
        }
        .onAppear {
            HapticManager.shared.playSelectButtonHaptic()
        }
    }
}

#Preview {
    MainView()
}
