//
//  ForecastHourView.swift
//  WeatherChallenge
//
//  Created by Manuel Moyano on 30/08/2022.
//

import SwiftUI

struct ForecastHourView: View {
    @State var dataResponseHours = Response()
    @State var selectedCity: City
    let currentTime = NetWorkingProvider.shared.getcurrentTime(time: true, hours: 24, days: 0)
    
    
    
    var body: some View {
            ScrollView(.horizontal){
                HStack {
                    ForEach (0..<23){ num in
                        VStack{
                            Text("\(currentTime[num]):00")
                            Image("\(Int(dataResponseHours.data?[4].coordinates?[0].dates?[num].value ?? 0.0))" )
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                            Text("\(dataResponseHours.data?[0].coordinates?[0].dates?[num].value ?? 0.0, specifier: "%.0f") ºC" )
                            HStack{
                                Image(systemName: "drop.fill")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 10))
                                Text("\(dataResponseHours.data?[3].coordinates?[0].dates?[num].value ?? 0.0, specifier: "%.0f") %" )
                            }
                        }
                    }
                }
                .background(.thinMaterial)
            }.onAppear {
                NetWorkingProvider.shared.getData(latitud: selectedCity.latitude, longitud: selectedCity.longitude, kValidDateTime: NetWorkingProvider.shared.kvalidDateTimeNowForecastHours){ response in
                    dataResponseHours = response
                } failure: { error in
                    print(error ?? "No error description")
                }
            }
    }
}

struct ForecastHourView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastHourView(selectedCity: City.example)
    }
}
