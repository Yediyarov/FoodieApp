//
//  MapView.swift
//  Foodie
//
//  Created by Khayal Yediyarov on 21.12.22.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    var location: String = "28 mall"
    
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.510357, longitude: -0.116773), span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0))
    
    @State private var annotatedItem: AnnotatedItem = AnnotatedItem(coordinate: CLLocationCoordinate2D(latitude: 51.510357, longitude: -0.116773))
    
    private func convertAddress(location: String) {
        // Get location
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(location, completionHandler: { placemarks, error in
    
            if let error = error {
                print(error.localizedDescription)
                return
    }
            guard let placemarks = placemarks,
                  let location = placemarks[0].location else {
                return
            }
            
            self.region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.0015, longitudeDelta: 0.0015))
            
            self.annotatedItem = AnnotatedItem(coordinate: location.coordinate)
        })
    }
    
    
    var body: some View {
        Map(coordinateRegion: $region, interactionModes: [.all], annotationItems: [annotatedItem])
        { item in
            MapMarker(coordinate: item.coordinate, tint: .red)
        } .task {
            convertAddress(location: location)
        }
    }
}


struct AnnotatedItem: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
