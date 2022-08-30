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
            VStack(alignment: .leading){
                Text(ubicacion)
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.white)
                
                HStack{
                    VStack(alignment: .leading) {
                        HStack{
                            Text("Temperatura")
                        Text("\(dataResponse.data?[0].coordinates?[0].dates?[0].value ?? 0.0, specifier: "%.1f") ºC" )
                            .font(.largeTitle)
                        }
                        HStack{
                            Text("Prob.Lluvia")
                            Text("\(dataResponse.data?[3].coordinates?[0].dates?[0].value ?? 0.0, specifier: "%.0f")%" )
                                .font(.largeTitle)
                        }
                    }
                    Spacer()
                    Image("\(Int(dataResponse.data?[4].coordinates?[0].dates?[0].value ?? 0.0))" )
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
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
        
        
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(ubicacion: "Ubicación Actual", latitud: 0.0, longitud: 0.0)
    }
}
