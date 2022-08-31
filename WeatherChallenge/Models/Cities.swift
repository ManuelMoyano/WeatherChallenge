//
//  Cities.swift
//  WeatherChallenge
//
//  Created by Manuel Moyano on 26/08/2022.
//

import Foundation

class Cities: Decodable, ObservableObject {
    @Published var locations: [City]
    
    init(locations: [City]){
        self.locations = locations
    }
    
//    Manually conform to Decodable
    enum CodingKeys: CodingKey {
        case locations
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        locations = try container.decode([City].self, forKey: .locations)
    }
    
}

struct City: Decodable, Identifiable, Hashable {
    var id: Int
    var name: String
    var latitude: Double
    var longitude: Double
    
    static let example = City(id: 1, name: "New York", latitude: 40.71, longitude: -74)
}

