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
            
            HStack{
                Text("\(selectedCity.name)")
                    .font(.system(size: 30))
                    .padding()
                VStack(alignment: .leading) {
                    HStack{
                        Image(systemName: "thermometer")
                            .font(.system(size: 20))
                            .foregroundColor(.red)
                    Text("\(dataResponse.data?[0].coordinates?[0].dates?[0].value ?? 0.0, specifier: "%.1f") ºC" )
                        .font(.system(size: 20))
                    }
                    HStack{
                        Image(systemName: "drop.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.blue)
                        Text("\(dataResponse.data?[1].coordinates?[0].dates?[0].value ?? 0.0, specifier: "%.0f")%" )
                            .font(.system(size: 20))
                        
                    }
                }
                Spacer()
                Image("\(Int(dataResponse.data?[2].coordinates?[0].dates?[0].value ?? 0.0))" )
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.gray, lineWidth: 4)
                    .background(.gray)
                    .blur(radius: 100)
            )
        }

        .onAppear {
            NetWorkingProvider.shared.getData(latitud: selectedCity.latitude, longitud: selectedCity.longitude){ response in
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
