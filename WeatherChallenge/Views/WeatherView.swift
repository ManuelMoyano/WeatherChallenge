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
        
        VStack(alignment: .leading){
            Text(ubicacion)
                .font(.system(size: 30))
            
            HStack{
                VStack(alignment: .leading) {
                    HStack{
                        Text("Temperatura")
                    Text("\(dataResponse.data?[0].coordinates?[0].dates?[0].value ?? 0.0, specifier: "%.1f") ºC" )
                        .font(.largeTitle)
                    }
                    HStack{
                        Text("Humedad")
                        Text("\(dataResponse.data?[1].coordinates?[0].dates?[0].value ?? 0.0, specifier: "%.0f")%" )
                            .font(.largeTitle)
                    }
//                    HStack{
//                        Text("Icono")
//                        Text("\(dataResponse.data?[2].coordinates?[0].dates?[0].value ?? 0.0, specifier: "%.0f")" )
//                            .font(.largeTitle)
//                    }
                }
                Spacer()
                Image("\(Int(dataResponse.data?[2].coordinates?[0].dates?[0].value ?? 0.0))" )
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            }
        }
        .padding()
        .padding(.leading,20)
        .padding(.trailing,20)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.white, lineWidth: 4)
        )
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
        .onAppear {
            NetWorkingProvider.shared.getData(latitud: latitud, longitud: longitud){ response in
                dataResponse = response
            } failure: { error in
                print(error ?? "No error description")
            }
        }
        
        
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(ubicacion: "Ubicación Actual", latitud: 0.0, longitud: 0.0)
    }
}
