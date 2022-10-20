//
//  HapticManager.swift
//  TipCalculator
//
//  Created by Pann Cherry on 4/26/22.
//  Copyright © 2022 Pann Cherry. All rights reserved.
//

import UIKit
import CoreHaptics

enum HapticFeedbackType {
    case custom
    case impactLight
    case impactMedium
    case impactHeavy
    case selection
    case notification
}

class HapticManager {

    var customHapticsEngine: Any?
    var lightImpactFeedbackGenerator: UIImpactFeedbackGenerator?
    var mediumImpactFeedbackGenerator: UIImpactFeedbackGenerator?
    var heavyImpactFeedbackGenerator: UIImpactFeedbackGenerator?
    var selectionFeedbackGenerator: UISelectionFeedbackGenerator?
    var notificationFeedbackGenerator: UINotificationFeedbackGenerator?

    private var preparedFeedbackTypes: [HapticFeedbackType]

    static var customHapticFeedbackSupported: Bool {
        return CHHapticEngine.capabilitiesForHardware().supportsHaptics
    }

    private var canPlayCustomHaptics: Bool {
        return HapticManager.customHapticFeedbackSupported
    }

    // We pass in specific types of feedback that we want our instance to play so that only those feedback generators are initialized
    // and prepared.  No need for the overhead of having all types of feedback generators sitting in memory and running.
    init(feedbackTypes: [HapticFeedbackType] = [.custom, .impactMedium, .selection, .notification]) {
        self.preparedFeedbackTypes = feedbackTypes

        self.initCustomFeedbackEngine()
        self.initImpactFeedbackGenerators()
        self.initSelectionFeedbackGenerator()
        self.initNotificationFeedbackGenerator()
    }

    private func initImpactFeedbackGenerators() {
        if (self.preparedFeedbackTypes.contains(.impactLight)) {
            self.lightImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
            self.lightImpactFeedbackGenerator?.prepare()
        }

        if (self.preparedFeedbackTypes.contains(.impactMedium)) {
            self.mediumImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
            self.mediumImpactFeedbackGenerator?.prepare()
        }

        if (self.preparedFeedbackTypes.contains(.impactHeavy)) {
            self.heavyImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
            self.heavyImpactFeedbackGenerator?.prepare()
        }
    }

    private func initSelectionFeedbackGenerator() {
        guard self.preparedFeedbackTypes.contains(.selection) else {
            return
        }

        self.selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        self.selectionFeedbackGenerator?.prepare()
    }

    private func initNotificationFeedbackGenerator() {
        guard self.preparedFeedbackTypes.contains(.notification) else {
            return
        }

        self.notificationFeedbackGenerator = UINotificationFeedbackGenerator()
        self.notificationFeedbackGenerator?.prepare()
    }

    private func initCustomFeedbackEngine() {
        guard self.preparedFeedbackTypes.contains(.custom) else {
            return
        }

        if (HapticManager.customHapticFeedbackSupported) {
            do {
                self.customHapticsEngine = try CHHapticEngine()

                guard let engine = self.customHapticsEngine as? CHHapticEngine else {
                    return
                }

                engine.stoppedHandler = { reason in
                    print("haptic engine stopped for reason: \(reason.rawValue)")
                }

                engine.resetHandler = {
                    do {
                        try engine.start()
                    } catch {
                        fatalError("Failed to restart the engine: \(error)")
                    }
                }

                try engine.start()
            } catch {
                print(error)
            }
        }
    }
}


// MARK: - Public Feedback API
extension HapticManager {
    func playLightImpact() {
        self.lightImpactFeedbackGenerator?.impactOccurred()
        self.lightImpactFeedbackGenerator?.prepare()
    }

    func playMediumImpact() {
        self.mediumImpactFeedbackGenerator?.impactOccurred()
        self.mediumImpactFeedbackGenerator?.prepare()
    }

    func playHeavyImpact() {
        self.heavyImpactFeedbackGenerator?.impactOccurred()
        self.heavyImpactFeedbackGenerator?.prepare()
    }

    func playSelectionFeedback() {
        self.selectionFeedbackGenerator?.selectionChanged()
        self.selectionFeedbackGenerator?.prepare()
    }

    func playErrorNotificationFeedback() {
        self.notificationFeedbackGenerator?.notificationOccurred(.error)
        self.notificationFeedbackGenerator?.prepare()
    }

    func playWarningNotificationFeedback() {
        self.notificationFeedbackGenerator?.notificationOccurred(.warning)
        self.notificationFeedbackGenerator?.prepare()
    }

    func playSuccessNotificationFeedback() {
        self.notificationFeedbackGenerator?.notificationOccurred(.success)
        self.notificationFeedbackGenerator?.prepare()
    }
}


// MARK: - Public Custom Feedback API
// TODO: Enable clients to pass in custom haptic dicts so they can be designed without changing this class.
extension HapticManager {
    func playLightTransientHaptic() {
        guard self.canPlayCustomHaptics else {
            return
        }

        guard let customHapticsEngine = self.customHapticsEngine as? CHHapticEngine else {
            return

        }

        let hapticDict = [
            CHHapticPattern.Key.pattern: [
                    [CHHapticPattern.Key.event: [
                        CHHapticPattern.Key.eventType: CHHapticEvent.EventType.hapticTransient,
                        CHHapticPattern.Key.time: 0.001,
                        CHHapticPattern.Key.eventDuration: 1.0
                    ]
                ]
            ]
        ]

        do {
            let pattern = try CHHapticPattern(dictionary: hapticDict)

            let player = try customHapticsEngine.makePlayer(with: pattern)
            customHapticsEngine.start(completionHandler:nil)
            try player.start(atTime: 0)
        } catch {
            print(error)
        }
    }
}
