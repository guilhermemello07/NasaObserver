//
//  HapticManager.swift
//  NasaObserver
//
//  Created by Guilherme Teixeira de Mello on 01/03/2025.
//

import Foundation
import CoreHaptics //SensoryFeedback is only available from iOS 17.0

class HapticManager {
    static let shared = HapticManager()
    private var engine: CHHapticEngine?
    
    private init() {
        createEngine()
    }
    
    
    private func createEngine() {
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Engine creation failed with error: \(error.localizedDescription)")
        }
    }
    
    
    func playLikeButtonHaptic() {
        guard let engine = engine else { return }
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
        let event = CHHapticEvent(eventType: .hapticTransient,
                                  parameters: [intensity, sharpness],
                                  relativeTime: 0)
        
        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: CHHapticTimeImmediate)
        } catch {
            print("Failed to play like button haptic: \(error.localizedDescription)")
        }
    }

    
    func playSelectButtonHaptic() {
        guard let engine = engine else { return }
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.3)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)
        let event = CHHapticEvent(eventType: .hapticTransient,
                                  parameters: [intensity, sharpness],
                                  relativeTime: 0)
        
        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: CHHapticTimeImmediate)
        } catch {
            print("Failed to play select button haptic: \(error.localizedDescription)")
        }
    }
    
    
    func playDeleteFeedbackHaptic() {
        guard let engine = engine else { return }
        
        let intensity1 = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.9)
        let sharpness1 = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.9)
        let event1 = CHHapticEvent(eventType: .hapticTransient,
                                   parameters: [intensity1, sharpness1],
                                   relativeTime: 0)
        
        let intensity2 = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.9)
        let sharpness2 = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.2)
        let event2 = CHHapticEvent(eventType: .hapticTransient,
                                   parameters: [intensity2, sharpness2],
                                   relativeTime: 0.1)
        
        do {
            let pattern = try CHHapticPattern(events: [event1, event2], parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: CHHapticTimeImmediate)
        } catch {
            print("Failed to play delete feedback haptic: \(error.localizedDescription)")
        }
    }
    
}
