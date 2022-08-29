//
//  MapView.swift
//  WeatherChallenge
//
//  Created by Manuel Moyano on 26/08/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @State var locationViewModel = LocationViewModel()
    
    var body: some View {
        Map(coordinateRegion: $locationViewModel.userLocation, showsUserLocation: true)
            .ignoresSafeArea()
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
