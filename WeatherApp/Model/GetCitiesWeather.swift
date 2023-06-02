//
//  GetCitiesWeather.swift
//  WeatherApp
//
//  Created by Мария  on 26.04.23.
//

import Foundation
import CoreLocation

func getCityWeather(cities:[String],complition :@escaping(Int,Weather)->Void){
    for (index,item) in cities.enumerated() {
        getCoordinateFrom(city: item) { coordinate, error in
            guard let coordinate =  coordinate, error == nil else {return}
            NetworkWeatherManager.shared.fetchWeather(latitude: coordinate.latitude, longitude: coordinate.longitude) { weather in
                complition(index,weather)
            }
        }
    }
}
func getCoordinateFrom(city:String, complition:@escaping(_ coordinate:CLLocationCoordinate2D?,_ error: Error?)->()){
    CLGeocoder().geocodeAddressString(city) { placemark, error in
        complition(placemark?.first?.location?.coordinate, error)
    }
}
