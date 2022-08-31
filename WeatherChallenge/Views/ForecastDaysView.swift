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
                        .frame(width: 35, height: 10, alignment: .leading)
                    HStack{
                    Image(systemName: "drop.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 10))
                        .shadow(color: .gray, radius: 5, x: 1, y: 1)
                    Text("\(dataResponseDays.data?[3].coordinates?[0].dates?[num].value ?? 0.0, specifier: "%.0f") %" )
                            .font(.system(size: 15))
                    }.frame(width: 60, height: 10, alignment: .leading)
                    
                    Image("\(Int(dataResponseDays.data?[4].coordinates?[0].dates?[0].value ?? 0.0))" )
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .shadow(color: .gray, radius: 10, x: 1, y: 1)
                    Text("max")
                    Text("\(dataResponseDays.data?[1].coordinates?[0].dates?[num].value ?? 0.0, specifier: "%.0f") ºC" )
                    Text("min")
                    Text("\(dataResponseDays.data?[2].coordinates?[0].dates?[num].value ?? 0.0, specifier: "%.0f") ºC" )
                }
            }
        }
        .listStyle(.plain)
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 10, y: 0)
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
