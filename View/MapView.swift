//
//  MapView.swift
//  Foodie
//
//  Created by Khayal Yediyarov on 21.12.22.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    var location: String = ""
    
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.510357, longitude: -0.116773), span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0))
    
    var body: some View {
        Map(coordinateRegion: $region)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
