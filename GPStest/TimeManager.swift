//
//  TimeManager.swift
//  GPStest
//
//  Created by sakurai sumika on 2024/10/29.
//

import SwiftUI
import MapKit

class TimerManager: ObservableObject {
    @Published var timer: Timer?
    @Published var timeInterval: Double = 1.0
    @Published var currentYaw: Double = 0.0
    @ObservedObject var headTrackingManager: HeadTrackingManager
    private var isTracking = false
    let musicPlayer: SoundPlayer
    let locationManager: LocationManager
    let junction: CLLocationCoordinate2D
    let direction: Int
    var junCount = 0
    var isAtJunction = 0
//    var targetDirection = direction // 交差点到着後の目的方向
    
    
    init(locationManager: LocationManager, headTrackingManager: HeadTrackingManager, musicPlayer: SoundPlayer, junction: CLLocationCoordinate2D, direction: Int) {
        self.locationManager = locationManager
        self.headTrackingManager = headTrackingManager
        self.musicPlayer = musicPlayer
        self.junction = junction
        self.direction = direction
    }

    func startTask() {
        stopTask() // 既存のタイマーがある場合には停止
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { _ in
            self.timerTask()
        }
    }
    
    func stopTask() {
        timer?.invalidate()
        timer = nil
        print("Timer stopped.")
    }
    
    func updateYaw(_ newYaw: Double) {
        self.currentYaw = newYaw
    }
    
    private func timerTask() {
        var source = "0"
        let ranges = -9...9
        let step = 20
        let baseNum = 0.17
        
//        print("Current yaw: \(currentYaw)")
        
        if let location = locationManager.location {
            let userLocation = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            let distance = userLocation.distance(from: junction)
            if isAtJunction == 0 {
//                let adjustedVolume = max(Float((20 - distance) * 0.1), 0.1)
                let adjustedVolume = Float(0.7) // 変数固定
//                let adjustedPitch = max(Int(((16 - distance)/2).rounded(.down)), 0)
                let adjustedPitch = 0 // 変数固定
                
//                timeInterval = distance * 0.1
                timeInterval = 1.0 // 変数固定
                
                musicPlayer.musicPlayer(source: "Marimba_\(source)_pitch_\(adjustedPitch)", vol: adjustedVolume)
                
                if distance <=  5.0 {
                    junCount += 1
                    if junCount >= 3 {
                        print("at junction")
                        musicPlayer.musicPlayer(source: "maou_se_onepoint23", vol: 0.1)
                        Thread.sleep(forTimeInterval: 1.0)
                        timeInterval = 1.0
                        isAtJunction = 1
                    }
                }
            } else {
                for i in ranges {
                    let lowerBound = baseNum * Double(i * 2 - 1)
                    let upperBound = baseNum * Double(i * 2 + 1)
                    var targetValue = direction + (i * step)
                    
                    if currentYaw >= lowerBound && currentYaw <= upperBound {
                        if targetValue > 180 {
                            targetValue = targetValue - 360
                        } else if targetValue < -180 {
                            targetValue = targetValue + 360
                        }
                        source = targetValue >= 0 ? "\(targetValue)" : "d\(abs(targetValue))"
                    }
                }
                print(source) // ちょっと怪しいから本当は平均とかとったほうがいい
                musicPlayer.musicPlayer(source: "Marimba_\(source)_pitch_0", vol: 0.7)
            }
        }
    }
}
