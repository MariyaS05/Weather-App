//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Мария  on 26.04.23.
//

import UIKit
import SwiftSVG

class DetailViewController: UIViewController {
    
    var weather:Weather!
    
    @IBOutlet weak var nameCityLabel: UILabel!
    @IBOutlet weak var viewCityWeather: UIView!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var tempCityLabel: UILabel!
    @IBOutlet weak var preasureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        refrashLabels()
    }
    func refrashLabels(){
        
        nameCityLabel.text =  weather.name
        conditionLabel.text = weather.conditionSrting
        tempCityLabel.text = "\(String(describing: weather.temperature))"
        preasureLabel.text =  "\(String(describing: weather.presure))"
        windSpeedLabel.text = "\(String(describing: weather.windSpeed))"
        guard let maxTemp = weather.tempMax else {return}
        guard let minTemp =  weather.tempMin else {return}
        minTempLabel.text = "\(String(describing: minTemp))"
        maxTempLabel.text = "\(String(describing: maxTemp))"
        guard let url = URL(string: "https://yastatic.net/weather/i/icons/funky/dark/\(weather.conditionCode).svg") else {return}
        let view =  UIView(SVGURL: url) { image in
            image.resizeToFit(self.viewCityWeather.bounds)
        }
        
        self.viewCityWeather.addSubview(view)
    }
}
