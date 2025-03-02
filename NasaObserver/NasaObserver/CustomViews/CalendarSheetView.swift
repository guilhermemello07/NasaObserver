//
//  CalendarSheetView.swift
//  NasaObserver
//
//  Created by Guilherme Teixeira de Mello on 28/02/2025.
//

import SwiftUI

struct CalendarSheetView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var orientationObserver: OrientationObserver
    @State private var localDate: Date
    
    let onDone: (Date) -> Void
    
    let isIpad: Bool = Deviceidentifier.shared.isIpad()
    
    let minDate: Date = { //The date for the first APOD
        var components = DateComponents()
        components.year = 1995
        components.month = 6
        components.day = 16
        return Calendar.current.date(from: components) ?? Date.distantPast
    }()

    init(currentDate: Date, onDone: @escaping (Date) -> Void) {
        _localDate = State(initialValue: currentDate)
        self.onDone = onDone
    }
    
    var body: some View {
        VStack {
            DatePicker("Select Date", selection: $localDate, in: minDate...Date.now, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .padding(.top, 20)
        }
        .overlay(
            HStack {
                Button("Done") {
                    HapticManager.shared.playSelectButtonHaptic()
                    onDone(localDate)
                    dismiss()
                }
                .padding(.top, isIpad ? 30 : orientationObserver.isPortrait ? 16 : 30)
                .padding(.trailing, isIpad ? 20 : 20)
            },
            alignment: .topTrailing
        )
        .padding(10)
    }
}
