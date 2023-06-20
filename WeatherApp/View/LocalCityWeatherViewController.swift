//
//  LocalCityWeatherViewController.swift
//  WeatherApp
//
//  Created by Мария  on 13.06.23.
//

import UIKit
import CoreLocation

class LocalCityWeatherViewController: UIViewController {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var viewCityWeather: UIView!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var tempCityLabel: UILabel!
    @IBOutlet weak var preasureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    var locationManager : CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.delegate =  self
        locationManager?.requestLocation()
        locationManager?.requestAlwaysAuthorization()
    }
    private func uptade(with weather: Weather){
        conditionLabel.text =  String(weather.conditionSrting)
        tempCityLabel.text =  String(weather.temperature)
        preasureLabel.text =  String(weather.presure)
        windSpeedLabel.text =  String(weather.windSpeed)
        minTempLabel.text =  String(weather.tempMin)
        maxTempLabel.text =  String(weather.tempMax)
        view.backgroundColor = UIColor(patternImage: (UIImage(named: weather.background)!))
        guard let url = URL(string: "https://yastatic.net/weather/i/icons/funky/dark/\(weather.conditionCode).svg") else {return}
        let view =  UIView(SVGURL: url) { image in
            image.resizeToFit(self.viewCityWeather.bounds)
        }
        self.viewCityWeather.addSubview(view)
    }
    private func clearUI(){
        conditionLabel.text = "Неизвестно"
        tempCityLabel.text =  "?"
        preasureLabel.text = "?"
        windSpeedLabel.text = "?"
        minTempLabel.text = "?"
        maxTempLabel.text = "?"
        let view =  UIImageView(image: UIImage(systemName: "questionmark"))
        view.frame = viewCityWeather.frame
        viewCityWeather.addSubview(view)
    }
}
//MARK: - CLLOcationManagerDelegate
extension LocalCityWeatherViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return
        }
        locationManager?.stopUpdatingLocation()
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        NetworkWeatherManager.shared.fetchWeather(latitude: lat, longitude: lon) { weather,error  in
            
            guard let weather =  weather  else {
                DispatchQueue.main.async {
                    self.clearUI()
                    self.presentCustomAlert(with: "Что-то пошло не так", message: "Проверьте соединение с интернетом", buttonTitle: "ОК")
                }
                return
            }
            DispatchQueue.main.async {
                self.uptade(with: weather)
            }
        }
        location.fetchCity { city, error in
            self.cityNameLabel.text =  city
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
