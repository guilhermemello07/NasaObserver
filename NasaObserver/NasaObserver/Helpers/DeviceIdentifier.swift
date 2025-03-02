//
//  DeviceIdentifier.swift
//  NasaObserver
//
//  Created by Guilherme Teixeira de Mello on 02/03/2025.
//

import SwiftUI


class Deviceidentifier {
    static let shared = Deviceidentifier()
    
    private init() { }
    
    func isIpad() -> Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
}
