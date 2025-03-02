//
//  OrientationObserver.swift
//  NasaObserver
//
//  Created by Guilherme Teixeira de Mello on 02/03/2025.
//

import SwiftUI
import Combine

class OrientationObserver: ObservableObject {
    @Published var isPortrait: Bool = true
    
    private var cancellable: AnyCancellable?
    
    init() {
        updateOrientation()
        self.cancellable = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.updateOrientation()
            }
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func updateOrientation() {
        let orientation = UIDevice.current.orientation
        if orientation.isValidInterfaceOrientation {
            self.isPortrait = orientation.isPortrait
        }
    }
}

// UI will respond only if is valid orientation
extension UIDeviceOrientation {
    var isValidInterfaceOrientation: Bool {
        return self == .portrait || self == .landscapeLeft || self == .landscapeRight
    }
}
