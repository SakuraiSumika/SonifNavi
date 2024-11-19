//
//  RouteCalculator.swift
//  GPStest
//
//  Created by sakurai sumika on 2024/10/29.
//

import SwiftUI
import MapKit

class RouteCalculator: ObservableObject {
    @Published var route: MKRoute?
    
    func calculateRoute(from location: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, transportType: MKDirectionsTransportType) async {
        let sourcePlacemark = MKPlacemark(coordinate: location)
        let destinationPlacemark = MKPlacemark(coordinate: destination)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: sourcePlacemark)
        request.destination = MKMapItem(placemark: destinationPlacemark)
        request.transportType = transportType
        
        if request.transportType == .transit {
            let directions = MKDirections(request: request)
            do {
                let etaResponse = try await directions.calculateETA()
                let etaSeconds = etaResponse.expectedTravelTime
                let etaMinutes = Int(etaSeconds / 60)
                print("ETA: \(etaMinutes) minutes")
            } catch {
                print("ETA Error: \(error.localizedDescription)")
            }
        } else {
            do {
                let directions = MKDirections(request: request)
                let response = try await directions.calculate()
                DispatchQueue.main.async {
                    self.route = response.routes.first
                }
            } catch {
                print("Route Calculation Error: \(error.localizedDescription)")
            }
        }
    }
}

