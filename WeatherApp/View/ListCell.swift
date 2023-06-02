//
//  ListCell.swift
//  WeatherApp
//
//  Created by Мария  on 26.04.23.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet weak var nameCityLabel: UILabel!
    @IBOutlet weak var conditionCityLabel: UILabel!
    @IBOutlet weak var tempCityLabel: UILabel!
    
    func configure(weather:Weather){
        self.nameCityLabel.text = weather.name
        self.conditionCityLabel.text =  weather.conditionSrting
        self.tempCityLabel.text =  String(weather.temperature)
        
    }
}
