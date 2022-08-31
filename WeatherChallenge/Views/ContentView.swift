//
//  ContentView.swift
//  WeatherChallenge
//
//  Created by Manuel Moyano on 25/08/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    @StateObject var selectedCities = Cities(locations: [City]())
    @State private var showingPickingSheet = false
    @State private var showingCityAlert = false
    @State private var showingLocationSheet = false
    
    func removeItems(at offsets: IndexSet) {
        selectedCities.locations.remove(atOffsets: offsets)
    }
    
    var body: some View {

        NavigationView {
            ZStack {
                VStack(alignment: .leading){
                    WeatherView(ubicacion: "Ubicación Actual", latitud: Double(locationViewModel.userLocation.center.latitude), longitud: Double(locationViewModel.userLocation.center.longitude))
                        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
                    Button {
                        if selectedCities.locations.count < 5 {
                            showingPickingSheet.toggle()
                        } else {
                            showingCityAlert.toggle()
                        }
                    } label: {
                        Text ("Add City")
                            .padding(.leading, 20)
                        Image(systemName: "plus")
                    }.sheet(isPresented: $showingPickingSheet) {
                        Pickingview(selectedCities: selectedCities)
                    }
                    .alert("Can't add more than 5 cities, swipe to delete ", isPresented: $showingCityAlert) {
                        Button("OK") { }
                    }
                    Spacer()
                        Section{
                            List{
                                ForEach (selectedCities.locations, id: \.self){ city in
                                    NavigationLink {
                                        DetailView(selectedCity: city)
                                    } label:{
                                    SelectedCityView(selectedCity: city)
                                    }
                                }.onDelete(perform: removeItems)
                            }
                            .listStyle(.plain)
                            
                        }
                }
            }
        }
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
