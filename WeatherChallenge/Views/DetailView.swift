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
//                RoundedRectangle(cornerRadius: 25, style: .continuous)
//                    .fill(.blue)
//                    .shadow(radius: 10)
//                    .blur(radius: 200)
//                VStack{
//                    Text("\(selectedCity.name)")
//                        .font(.system(size: 30))
//                        .padding()
//                    HStack{
//                    VStack(alignment: .leading) {
//                        HStack{
//                            Image(systemName: "thermometer")
//                                .font(.system(size: 20))
//                                .foregroundColor(.red)
//                        Text("\(dataResponseDays.data?[0].coordinates?[0].dates?[0].value ?? 0.0, specifier: "%.1f") ºC" )
//                            .font(.system(size: 20))
//                        }
//                        HStack{
//                            Image(systemName: "drop.fill")
//                                .font(.system(size: 20))
//                                .foregroundColor(.blue)
//                            Text("\(dataResponseDays.data?[3].coordinates?[0].dates?[0].value ?? 0.0, specifier: "%.0f")%" )
//                                .font(.system(size: 20))
//                        }
//                    }
//                    Image("\(Int(dataResponseDays.data?[4].coordinates?[0].dates?[0].value ?? 0.0))" )
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 100, height: 100)
//                }
//                }
            }
            
            ForecastHourView(selectedCity: selectedCity)
            
            ForecastDaysView(selectedCity: selectedCity)
                
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
