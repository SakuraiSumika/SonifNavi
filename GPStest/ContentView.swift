//
//  MapPolylineSample.swift
//  MapKitSamplerForiOS17
//
//  Created by yuji on 2024/03/14.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var headTrackingManager = HeadTrackingManager()
    @StateObject private var timerManager: TimerManager
    @StateObject private var routeCalculator = RouteCalculator()
    @State private var isTracking = false
    
    private var route: CLLocationCoordinate2D.Route
    private var destination: CLLocationCoordinate2D
    private var junction: CLLocationCoordinate2D
    private var direction: Int
    
    init() {
        let route = CLLocationCoordinate2D.kasugatennis // ルートを設定
        
        self.route = route
        self.destination = route.distination // マップ表示ルート用
        self.junction = route.junction // 交差点の位置情報
        self.direction = route.direction // 曲がった先の方向
        
        _timerManager = StateObject(wrappedValue: TimerManager(
            locationManager: LocationManager(),
            headTrackingManager: HeadTrackingManager(),
            musicPlayer: SoundPlayer(),
            junction: route.junction,
            direction: route.direction
        ))
    }
    
    var body: some View {
        VStack {
            Map(interactionModes: .all) {
                UserAnnotation(anchor: .center) { userLocation in
                    VStack {
                        Circle()
                            .foregroundStyle(.blue)
                            .padding(2)
                            .background(
                                Circle()
                                    .fill(.white)
                            )
                        
                        // 現在地から交差点までの距離(m)
                        if let location = locationManager.location {
                            let userlocation = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                            let distance = userlocation.distance(from: junction)
                            Text(String(distance)+" m")
                        } else {
                            Text("位置情報を取得中...")
                        }
                        
                    }
                }
                
                if let routePolyline = routeCalculator.route?.polyline {
                    MapPolyline(routePolyline)
                        .stroke(.blue, lineWidth: 8)
                }
                
            }
            .safeAreaInset(edge: .bottom) {
                HStack(spacing: 32) {
                    Spacer()
                    Button {
                        if isTracking {
                            headTrackingManager.stopTracking()
                            timerManager.stopTask()
                        } else {
                            headTrackingManager.startTracking()
                            Thread.sleep(forTimeInterval: 1.0)
                            timerManager.startTask()
                        }
                        isTracking.toggle()
                    } label: {
                        Text(isTracking ? "Stop Tracking" : "Start Tracking")
                            .padding()
                            .background(isTracking ? Color.red : Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                    Spacer()
                }
                .background(.thinMaterial)
            }
            
        }
        .task {
            if let location = locationManager.location {
                let userCoordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                await routeCalculator.calculateRoute(from: userCoordinate, to: destination, transportType: .walking)
            }
        }
        .onChange(of: timerManager.timeInterval) { newInterval, oldInterval in
            if newInterval != oldInterval {
                timerManager.startTask()
            }
        }
        .onChange(of: headTrackingManager.yaw) { newYaw in
            timerManager.updateYaw(newYaw) // yawが変わった時に更新
        }
    }
}


#Preview {
    ContentView()
}

