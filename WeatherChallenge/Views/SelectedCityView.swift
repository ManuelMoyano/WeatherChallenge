//
//  SelectedCityView.swift
//  WeatherChallenge
//
//  Created by Manuel Moyano on 29/08/2022.
//

import SwiftUI

struct SelectedCityView: View {
    @State private var dataResponse = Response()
    @State var selectedCity: City
    
    
    var body: some View {
        ZStack{
            Color.gray
                .opacity(0.2)
                .cornerRadius(16)
            HStack{
                Text("\(selectedCity.name)")
                    .font(.system(size: 20, weight: .bold))
                VStack(alignment: .leading) {
                    HStack{
                        Image(systemName: "thermometer")
                            .font(.system(size: 20))
                            .foregroundColor(.red)
                            .shadow(color: .red, radius: 5, x: 1, y: 1)
                    Text("\(dataResponse.data?[0].coordinates?[0].dates?[0].value ?? 0.0, specifier: "%.1f") ºC" )
                        .font(.system(size: 20))
                    }
                    HStack{
                        Image(systemName: "drop.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.blue)
                            .opacity(0.4)
                        Text("\(dataResponse.data?[3].coordinates?[0].dates?[0].value ?? 0.0, specifier: "%.0f")%" )
                            .font(.system(size: 20))
                        
                    }
                }
                Image("\(Int(dataResponse.data?[4].coordinates?[0].dates?[0].value ?? 0.0))" )
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .shadow(color: .blue, radius: 30, x: 7, y: 7)
            }
        }
        .frame(height: 100)
        .onAppear {
            NetWorkingProvider.shared.getData(latitud: selectedCity.latitude, longitud: selectedCity.longitude, kValidDateTime: NetWorkingProvider.shared.kValidDateTimeForecastDays){ response in
                dataResponse = response
            } failure: { error in
                print(error ?? "No error description")
            }
        }
    }
}

struct SelectedCityView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedCityView(selectedCity: City.example)
    }
}
