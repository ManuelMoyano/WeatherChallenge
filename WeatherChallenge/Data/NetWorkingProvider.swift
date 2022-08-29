//
//  NetWorkingProvider.swift
//  WeatherChallenge
//
//  Created by Manuel Moyano on 25/08/2022.
//

import Foundation
import Alamofire

final class NetWorkingProvider {
    
    static let shared = NetWorkingProvider()
    private init(){}
    
    private let kUsername = "freelance_moyano"
    private let kPassword = "06YIYQc5mo"
    private let kBaseUrl = "https://api.meteomatics.com/"
//    private let kValidDateTime = "2022-08-25T15:45Z"
    private let kValidDateTime = "now"
    private let kparameters = "t_2m:C,relative_humidity_2m:p,weather_symbol_1h:idx"
//    private let kLocation = "-32.94682,-60.63932"
    private let kFormat = "json"
    
    func getData (latitud: Double, longitud: Double, success: @escaping (_ token: Response) -> (), failure: @escaping (_ error: Error?) -> ()){
        
        
        let url = "\(kBaseUrl)/\(kValidDateTime)/\(kparameters)/\(latitud),\(longitud)/\(kFormat)"
        
        let headers: HTTPHeaders = [.authorization(username: kUsername, password: kPassword)]
        
        AF.request(url, method: .get, headers: headers).responseDecodable (of: Response.self) {  response in
            
            if let data = response.value {
                success(data)
                print("Se obtuvo la info")
                print(data)
                print("El URL es: \(url)")
            } else {
                print("No se genero la info por el error \(String(describing: response.error))")
                failure(response.error)
            }
        }
    }
    
}
