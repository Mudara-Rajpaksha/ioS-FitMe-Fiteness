//
//  LocationTrackerView.swift
//  FitMe
//
//  Created by Yesh Adithya on 2025-04-25.
//

import SwiftUI
import MapKit

struct LocationTrackerView: View {
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        VStack {
            if let userLocation = locationManager.userLocation {
                Map(coordinateRegion: .constant(
                    MKCoordinateRegion(
                        center: userLocation,
                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    )
                ), annotationItems: [userLocation]) { location in
                    MapMarker(coordinate: location, tint: .orange)
                }
                .frame(height: 600)
                .cornerRadius(12)
            } else {
                ProgressView("Locating you...")
            }
        }
        .padding()
    }
}

extension CLLocationCoordinate2D: @retroactive Identifiable {
    public var id: String {
        "\(latitude),\(longitude)"
    }
}

#Preview {
    LocationTrackerView()
}
