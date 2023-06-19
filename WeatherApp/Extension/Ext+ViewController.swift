//
//  Ext+ViewController.swift
//  WeatherApp
//
//  Created by Мария  on 13.06.23.
//

import Foundation
import UIKit
import CoreLocation

extension UIViewController {
    func presentAlert(name:String,placeholder: String,complitionHandler: @escaping(String)->Void){
        let alertVC =  UIAlertController(title: name, message: nil, preferredStyle: .alert)
        alertVC.addTextField { tf in
            tf.placeholder = placeholder
        }
        let alertOk = UIAlertAction(title: "Добавить", style: .default) { alert in
            guard let textField =  alertVC.textFields?.first else {return}
            guard textField.hasText else {
                return
            }
            guard let textFieldText = alertVC.textFields?.first?.text else {
                return
            }
            complitionHandler(textFieldText)
            
        }
        let alertCancel =  UIAlertAction(title: "Отмена", style: .cancel)
        alertVC.addAction(alertOk)
        alertVC.addAction(alertCancel)
        present(alertVC, animated: true)
    }
    func presentCustomAlert(with title : String, message : String, buttonTitle: String){
        let alertVC =  CustomAlertViewController(alertTitle: title, message: message, buttonTitle: buttonTitle)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        DispatchQueue.main.async { [weak self] in
            self?.present(alertVC, animated: true, completion: nil)
        }
    }
}
extension CLLocation {
    func fetchCity(completion: @escaping (_ city: String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality,$1) }
    }
}
