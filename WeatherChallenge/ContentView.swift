//
//  ContentView.swift
//  WeatherChallenge
//
//  Created by Manuel Moyano on 25/08/2022.
//

import SwiftUI

struct ContentView: View {
    @State var locationViewModel = LocationViewModel()
//    @State private var dataResponse = Response()
    @StateObject var selectedCities = Cities(locations: [City]())
    @State private var showingPickingSheet = false
    @State private var showingCityAlert = false
    
    func removeItems(at offsets: IndexSet) {
        selectedCities.locations.remove(atOffsets: offsets)
    }
    
    var body: some View {

        VStack(alignment: .leading){
            WeatherView(ubicacion: "Ubicación Actual", latitud: Double(locationViewModel.userLocation.center.latitude), longitud: Double(locationViewModel.userLocation.center.longitude))
                .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
            Button {
                if selectedCities.locations.count < 2 {
                    showingPickingSheet.toggle()
                } else {
                    showingCityAlert.toggle()
                }
            } label: {
                Text ("Add City")
                Image(systemName: "plus")
            }.sheet(isPresented: $showingPickingSheet) {
                Pickingview(selectedCities: selectedCities)
            }
            .alert("No puede agregar mas de 5 ciudades, por favor borre alguna", isPresented: $showingCityAlert) {
                Button("OK") { }
            }
            Text("Ciudades Seleccionadas: \(selectedCities.locations.count)")
            Spacer()
                Section{
                    List{
                        ForEach (selectedCities.locations, id: \.self){ city in
                            Text("\(city.name)")
                            SelectedCityView(selectedCity: city)
                        }.onDelete(perform: removeItems)
                    }
                    .listStyle(.plain)
                }
        }
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
