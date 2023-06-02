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
            guard ((alertVC.textFields?.first?.hasText) == nil) else {
                return
            }
            guard let textField = alertVC.textFields?.first?.text else {
                return
            }
            complitionHandler(textField)
        }
        let alertCancel =  UIAlertAction(title: "Отмена", style: .cancel)
        alertVC.addAction(alertOk)
        alertVC.addAction(alertCancel)
        present(alertVC, animated: true)
    }
}
