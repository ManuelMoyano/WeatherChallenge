//
//  DataModel.swift
//  WeatherChallenge
//
//  Created by Manuel Moyano on 25/08/2022.
//

import Foundation
import CoreLocation

//GET requests

//Limitations:
//1 single location per query
//10 parameters with one query
//500 queries per day
//15 basic weather parameters

//Format:
//https://api.meteomatics.com/<validdatetime>/<parameters>/<location>/<format>?<optionals>

//validdatetime:
//YYYY-MM-DDThh:mm:ssZ
//2015-01-20T18:45Z (Ejemplo)

//parameters
//t_2m:C Instantaneous temperature at 2m above ground in degrees Celsius (C)
//t_max_2m_24h:C Maximum temperature at 2m height in the previous 24h
//t_min_2m_24h:C Minimum temperature at 2m height in the previous 24h

//location
//Single point <lat>,<lon> 47.419708,9.358478
//Point list <lat1>,<lon1>+...+<latN>,<lonN>  47.41,9.35+47.51,8.74+47.13,8.22
//Rosario se encuentra en la latitud -32.94682 y longitud -60.63932

//fotmat
//json    Hierarchical structure in JSON.


//{
//"version":"3.0",
//"user":"freelance_moyano",
//"dateGenerated":"2022-08-25T19:15:20Z",
//"status":"OK",
//"data":[
//    {
//    "parameter":"t_2m:C",
//    "coordinates":[
//        {
//        "lat":52.520551,
//        "lon":13.461804,
//        "dates":[
//            {
//            "date":"2022-08-25T00:00:00Z",
//            "value":19.5
//            }
//        ]
//        }
//    ]
//    }
//]
//}



struct Response: Decodable {
    var version:String?
    var user:String?
    var dateGenerated: String?
    var status: String?
    var data:[QueryData]?
}

struct QueryData: Decodable {
    var parameter: String?
    var coordinates: [Coordinates]?
}

struct Coordinates: Decodable {
    var lat: Double?
    var lon: Double?
    var dates: [Dates]?
}

struct Dates: Decodable {
    var date:String?
    var value: Double?
}
