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
                                .font(.system(size: 10))
                                .padding(.top, 10)
                            Image("\(Int(dataResponseHours.data?[4].coordinates?[0].dates?[num].value ?? 0.0))" )
                                .resizable()
                                .scaledToFill()
                                .frame(width: 30, height: 20)
                                .shadow(color: .gray, radius: 5, x: 1, y: 1)
                                .padding(7)
                            Text("\(dataResponseHours.data?[0].coordinates?[0].dates?[num].value ?? 0.0, specifier: "%.0f") ºC" )
                                .font(.system(size: 10))
                            HStack{
                                Image(systemName: "drop.fill")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 10))
                                Text("\(dataResponseHours.data?[3].coordinates?[0].dates?[num].value ?? 0.0, specifier: "%.0f") %" )
                            }
                            .font(.system(size: 10))
                            .frame(height: 20, alignment: .center)
                            .padding(.bottom, 10)
                        }.padding(.leading, 20)
                    }
                }
                .background(.thinMaterial)
            }
            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 20, y: 10)
            .onAppear {
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
