//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Мария  on 25.04.23.
//

import Foundation
struct WeatherData: Codable {
    let info: Info
    let fact: Fact
    let forecast: Forecast
}
struct Info: Codable {
    let url: String
}
struct Fact: Codable {
    let temp : Int
    let icon: String
    let condition: String
    let windSpeed: Double
    let pressureMm : Int
    
    enum CodingKeys: String, CodingKey {
        case pressureMm = "pressure_mm"
        case windSpeed = "wind_speed"
        case temp
        case icon
        case condition
    }
}
struct Forecast : Codable {
    let parts: [Parts]
}
struct Parts: Codable {
    let partName: String
    let tempMin,tempMax: Int
    
    enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case partName = "part_name"
    }
}

