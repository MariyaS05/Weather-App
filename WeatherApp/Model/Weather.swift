//
//  Weather.swift
//  WeatherApp
//
//  Created by Мария  on 25.04.23.
//

import Foundation
import RealmSwift
class Weather : Object{
    @objc dynamic var name : String =  "Название"
    @objc dynamic var temperature : Int = 0
    @objc dynamic var conditionCode : String = ""
    @objc dynamic var url : String = ""
    @objc dynamic var condition : String = ""
    @objc dynamic var presure : Int = 0
    @objc dynamic var windSpeed : Double = 0
    @objc dynamic var tempMax : Int = 0
    @objc dynamic var tempMin : Int = 0
    
    @objc dynamic var conditionSrting : String {
        switch condition {
        case "clear" : return "Ясно"
        case "partly-cloudy": return "Малооблачно"
        case "cloudy": return "Облачно с прояснениями"
        case "overcast": return "Пасмурно"
        case "drizzle": return "Морось"
        case "light-rain": return "Небольшой дождь"
        case "rain": return "Дождь"
        case "moderate-rain": return "Умеренно сильный дождь"
        case "heavy-rain": return "Сильный дождь"
        case "continuous-heavy-rain": return "Длительный сильный дождь"
        case "showers": return "Ливень"
        case "wet-snow": return "Дождь со снегом"
        case "light-snow": return "Небольшой снег"
        case "snow": return "Снег"
        case "snow-showers": return "Снегопад"
        case "hail": return "Град"
        case "thunderstorm": return "Гроза"
        case "thunderstorm-with-rain": return "Дождь с грозой"
        case "thunderstorm-with-hail": return "Гроза с градом"
        default : return "Загрузка..."
        }
    }
    init(weatherData : WeatherData) {
        temperature = weatherData.fact.temp
        conditionCode =  weatherData.fact.icon
        url =  weatherData.info.url
        condition =  weatherData.fact.condition
        presure =  weatherData.fact.pressureMm
        windSpeed = weatherData.fact.windSpeed
        tempMax =  weatherData.forecast.parts.first!.tempMax
        tempMin =  weatherData.forecast.parts.first!.tempMin
    }
    override init(){
    }
}



