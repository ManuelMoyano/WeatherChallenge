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
    let kValidDateTimeForecastDays = "now--today+7DT00:00Z:P1D"
    let kvalidDateTimeNowForecastHours = "now--now+23H:PT1H"
    private let kparameters = "t_2m:C,t_max_2m_24h:C,t_min_2m_24h:C,prob_precip_1h:p,weather_symbol_1h:idx"
    private let kFormat = "json"
    
    
    func getData (latitud: Double, longitud: Double, kValidDateTime: String, success: @escaping (_ token: Response) -> (), failure: @escaping (_ error: Error?) -> ()){
        
        
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
    
    func getcurrentTime (time: Bool, hours: Int, days: Int)-> [String] {
        let now = Date.now
        let formatter = DateFormatter()
        var timeArray = [String]()
        var dateArray = [String]()
        
        if time {
            formatter.dateFormat = "HH"
            for i in 0..<hours {
                timeArray.append(formatter.string(from: now.addingTimeInterval(TimeInterval(3600*i))))
            }
            return timeArray
        } else {
        formatter.dateFormat = "E"
            
            for i in 0..<days {
                dateArray.append(formatter.string(from: now.addingTimeInterval(TimeInterval(86400*i))))
            }
            
            return dateArray
        }
        
    }
    
}
