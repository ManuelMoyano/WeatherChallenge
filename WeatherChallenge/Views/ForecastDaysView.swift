//
//  ForecastDaysView.swift
//  WeatherChallenge
//
//  Created by Manuel Moyano on 30/08/2022.
//

import SwiftUI

struct ForecastDaysView: View {
    @State private var dataResponseDays = Response()
    @State var selectedCity: City
    let currentTime = NetWorkingProvider.shared.getcurrentTime(time: false, hours: 0, days: 7)
    
    var body: some View {
        List{
            ForEach (0..<7){ num in
                HStack{
                    Text("\(currentTime[num])")
                    Image(systemName: "drop.fill")
                        .foregroundColor(.blue)
                    Text("\(dataResponseDays.data?[3].coordinates?[0].dates?[num].value ?? 0.0, specifier: "%.0f") %" )
                    Image("\(Int(dataResponseDays.data?[4].coordinates?[0].dates?[0].value ?? 0.0))" )
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                    Text("Tmax: \(dataResponseDays.data?[1].coordinates?[0].dates?[num].value ?? 0.0, specifier: "%.0f") ºC" )
                    Text("Tmin: \(dataResponseDays.data?[2].coordinates?[0].dates?[num].value ?? 0.0, specifier: "%.0f") ºC" )
                }
            }
        }
        .listStyle(.plain)
        .onAppear {
            NetWorkingProvider.shared.getData(latitud: selectedCity.latitude, longitud: selectedCity.longitude, kValidDateTime: NetWorkingProvider.shared.kValidDateTimeForecastDays){ response in
                    dataResponseDays = response
                } failure: { error in
                    print(error ?? "No error description")
                }
            }
    }
}

struct ForecastDaysView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastDaysView(selectedCity: City.example)
    }
}
