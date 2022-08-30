//
//  WeatherChallengeApp.swift
//  WeatherChallenge
//
//  Created by Manuel Moyano on 25/08/2022.
//

import SwiftUI

@main
struct WeatherChallengeApp: App {
    @State var locationViewModel = LocationViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationViewModel)
        }
    }
}
