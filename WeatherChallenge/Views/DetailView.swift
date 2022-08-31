//
//  DetailView.swift
//  WeatherChallenge
//
//  Created by Manuel Moyano on 29/08/2022.
//

import SwiftUI

struct DetailView: View {
    @State private var dataResponseDays = Response()
    @State private var dataResponseHours = Response()
    @State var selectedCity: City
    
    var body: some View {
        VStack{
            ZStack {
                WeatherView(ubicacion: selectedCity.name, latitud: selectedCity.latitude, longitud: selectedCity.longitude)
                    .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
            }
            .padding()
            ForecastHourView(selectedCity: selectedCity)
                .padding()
            
            ForecastDaysView(selectedCity: selectedCity)
                .padding()
                
        }
            .onAppear {
                NetWorkingProvider.shared.getData(latitud: selectedCity.latitude, longitud: selectedCity.longitude, kValidDateTime: NetWorkingProvider.shared.kValidDateTimeForecastDays){ response in
                    dataResponseDays = response
                } failure: { error in
                    print(error ?? "No error description")
                }
            }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(selectedCity: City.example)
    }
}
