//
//  Pickingview.swift
//  WeatherChallenge
//
//  Created by Manuel Moyano on 27/08/2022.
//

import SwiftUI

struct Pickingview: View {
    @Environment (\.dismiss) var dismiss
    @State var citiesViewModel = CitiesViewModel()
    @ObservedObject var selectedCities: Cities
    @State var selectedCity = City.example
    @State private var totalCities = Cities(locations: [City]())
    @State private var searchText = ""
    
    var searchResults: [City] {
        if searchText.isEmpty {
            return totalCities.locations
        } else {
            return totalCities.locations.filter { $0.name.contains(searchText) }
        }
    }

    
    var body: some View {
        NavigationView{
                List{
                    ForEach (searchResults, id: \.self) { city in
                        Text("\(city.name)")
                            .onTapGesture {
                                selectedCity = city
                            }
                    }
                        
                    
                    
                }
                .searchable(text: $searchText)
                .onAppear{
                    citiesViewModel.loadJSON { loadCities in
                        totalCities = loadCities
                    } failure: { error in
                        print(error)
                    }

                }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(
                leading:
                    HStack{
                        Text("Selected City:")
                            .font(.system(size: 20))
                        Text("\(selectedCity.name)")
                            .font(.system(size: 20))
                    },
                trailing:
                    Button("Done"){
                        selectedCities.locations.append(selectedCity)
                        print("Cantidad ciudades:\(selectedCities.locations.count)")
                        dismiss()
                    }
            )
        }
    }
}

struct Pickingview_Previews: PreviewProvider {
    static var previews: some View {
        Pickingview(selectedCities: Cities(locations: [City]()))
    }
}
