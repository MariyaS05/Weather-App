//
//  NetworkWeatherManager.swift
//  WeatherApp
//
//  Created by Мария  on 25.04.23.
//

import Foundation
class NetworkWeatherManager {
    static let shared = NetworkWeatherManager()
    func fetchWeather(latitude: Double, longitude: Double,completionHandler :  @escaping (Weather)->Void){
        let urlString = "https://api.weather.yandex.ru/v2/informers?lat=\(latitude)&lon=\(longitude)"
        guard let url = URL(string: urlString) else {return}
        var request =  URLRequest(url: url,timeoutInterval: Double.infinity)
        request.addValue("\(Constant.apiKey)", forHTTPHeaderField: Constant.header)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            guard let data = data else {
                print(String(describing: error))
                return
            }
            print(String(data: data, encoding: .utf8)!)
            
            if let weather  =  self.parseJSON(with: data) {
               completionHandler(weather)
            }
        }
        task.resume()
    }
    func parseJSON(with data: Data)->Weather?{
        let decoder  = JSONDecoder()
        do {
            let weatherData =  try decoder.decode(WeatherData.self, from: data)
            let weather = Weather(weatherData: weatherData)
            return weather
            
        }catch  let error as NSError {
            print(error)
        }
        return nil
    }
}
