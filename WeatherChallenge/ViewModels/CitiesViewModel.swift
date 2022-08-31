//
//  CitiesViewModel.swift
//  WeatherChallenge
//
//  Created by Manuel Moyano on 26/08/2022.
//

import Foundation

final class CitiesViewModel {
      
    func loadJSON (succes: @escaping(Cities)->(), failure: @escaping(String)->()){
        if let url = Bundle.main.url(forResource: "cities", withExtension: "json"),
            let data = try? Data(contentsOf: url) {
                let decoder = JSONDecoder()
                if let jsonData = try? decoder.decode(Cities.self, from: data) {
                    print(jsonData.locations)
                    print("Se cargaron los datos")
                    succes(jsonData)
                } else {
                    failure("Error al cargar las ciudades")
                }
            }
        }
    }
    
