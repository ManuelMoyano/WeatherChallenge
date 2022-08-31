//
//  WeatherView.swift
//  WeatherChallenge
//
//  Created by Manuel Moyano on 28/08/2022.
//

import SwiftUI
import MapKit

struct WeatherView: View {
    @State private var dataResponse = Response()
    @State var ubicacion: String
    @State var latitud: Double
    @State var longitud: Double
    
    
    var body: some View {
        
        
        ZStack {
            Color.blue
                .opacity(0.3)
                .cornerRadius(16)
            VStack(alignment: .leading){
                Text(ubicacion)
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.white)
                
                HStack{
                    VStack(alignment: .leading) {
                        HStack{
                            Image(systemName: "thermometer")
                                .font(.system(size: 20))
//                                .opacity(0.4)
                                .foregroundColor(.red)
                                .shadow(color: .red, radius: 10, x: 1, y: 1)
                        Text("\(dataResponse.data?[0].coordinates?[0].dates?[0].value ?? 0.0, specifier: "%.1f") ºC" )
                                .font(.system(size: 30, weight: .bold))
                                .foregroundColor(.white)
                        }
                        HStack{
                            Image(systemName: "drop.fill")
                                .foregroundColor(.blue)
                                .opacity(0.4)
                                .font(.system(size: 20))
                            Text("\(dataResponse.data?[3].coordinates?[0].dates?[0].value ?? 0.0, specifier: "%.0f")%" )
                        }                                .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Image("\(Int(dataResponse.data?[4].coordinates?[0].dates?[0].value ?? 0.0))" )
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .shadow(color: .blue, radius: 50, x: 7, y: 7)
                }
                
            }
            .padding()
            .padding(.leading,20)
            .padding(.trailing,20)
            .shadow(color: Color.blue.opacity(0.3), radius: 20, x: 0, y: 10)
            .onAppear {
                NetWorkingProvider.shared.getData(latitud: latitud, longitud: longitud, kValidDateTime: NetWorkingProvider.shared.kValidDateTimeForecastDays){ response in
                    dataResponse = response
                } failure: { error in
                    print(error ?? "No error description")
                }
        }
        }
        .frame(height: 180)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(ubicacion: "Ubicación Actual", latitud: 0.0, longitud: 0.0)
    }
}
