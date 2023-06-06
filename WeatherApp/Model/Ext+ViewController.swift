//
//  Ext+ViewController.swift
//  WeatherApp
//
//  Created by Мария  on 31.05.23.
//

import Foundation
import UIKit

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
}

