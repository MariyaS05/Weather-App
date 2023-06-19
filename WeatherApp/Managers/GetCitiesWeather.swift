//
//  GetCitiesWeather.swift
//  WeatherApp
//
//  Created by Мария  on 26.04.23.
//

import Foundation
import CoreLocation
 

enum GetCitiesWeather {
     static func getCityWeather(cities:[String],complition :@escaping(Int,Weather)->Void){
        for (index,item) in cities.enumerated() {
            getCoordinateFrom(city: item) { result in
                switch result {
                case .success(let coordinate):
                    NetworkWeatherManager.shared.fetchWeather(latitude: coordinate.latitude, longitude: coordinate.longitude) { weather in
                        complition(index,weather)
                    }
                    case .failure(let failure ):
                    print(failure)
                }
            }
        }
    }
    
    static func getCoordinateFrom(city:String, complition:@escaping(Result< CLLocationCoordinate2D,Error>)->()){
         CLGeocoder().geocodeAddressString(city) { placemark, error in
             guard error == nil else {
                 complition(.failure(error!))
                 return
             }
             complition(.success((placemark?.first?.location!.coordinate)!))
         }
     }
}
