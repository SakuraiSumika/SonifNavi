//
//  HeadTrackingManager.swift
//  Airpods test
//
//  Created by sakuraisumika on 2024/08/09.
//

import CoreMotion
import Foundation

@available(macOS 14.0, *)
class HeadTrackingManager: ObservableObject {
    private var motionManager: CMHeadphoneMotionManager
    @Published var pitch: Double = 0.0
    @Published var roll: Double = 0.0
    @Published var yaw: Double = 0.0

    init() {
        motionManager = CMHeadphoneMotionManager()
    }

    func startTracking() {
        guard motionManager.isDeviceMotionAvailable else {
            print("Headphone motion data is not available.")
            return
        }

        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (motion, error) in
            guard let self = self, let motion = motion, error == nil else {
                print("Error: \(String(describing: error))")
                return
            }

            Task {
                await self.updateMotionData(motion)
            }
        }
    }

    func stopTracking() {
        motionManager.stopDeviceMotionUpdates()
//        print("stop Tracking")
    }

    private func updateMotionData(_ motion: CMDeviceMotion) async {
        await MainActor.run {
            self.pitch = motion.attitude.pitch
            self.roll = motion.attitude.roll
            self.yaw = motion.attitude.yaw
        }
    }
}

