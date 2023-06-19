//
//  CustomAlertViewController.swift
//  WeatherApp
//
//  Created by Мария  on 16.06.23.
//

import UIKit

class CustomAlertViewController: UIViewController {
    
    let containerView =  UIView()
    let titleLabel =  UILabel()
    let messageLabel =  UILabel()
    let actionButton =  UIButton()

    var alertTitle : String?
    var message : String?
    var buttonTitle : String?
    
    let padding : CGFloat =  20
    
    init(alertTitle: String? = nil, message: String? = nil, buttonTitle: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContainerView()
        configureTitleLabels()
        configureMessageLabel()
        configureButton()
    }
    private func configureContainerView(){
        view.addSubview(containerView)
        containerView.backgroundColor = UIColor(cgColor: CGColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1))
        containerView.layer.cornerRadius =  16
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 200),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
    }
    private func configureTitleLabels(){
        containerView.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        titleLabel.textAlignment = .center
        titleLabel.text =  alertTitle ?? "Что-то пошло не так!"
        titleLabel.translatesAutoresizingMaskIntoConstraints =  false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    private func configureMessageLabel(){
        containerView.addSubview(messageLabel)
        messageLabel.text = message ?? "Попробуйте еще раз."
        messageLabel.textAlignment  = .center
        messageLabel.translatesAutoresizingMaskIntoConstraints =  false
        messageLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding/2),
            messageLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    private func configureButton(){
        containerView.addSubview(actionButton)
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.setTitle(buttonTitle, for: .normal)
        actionButton.backgroundColor = .systemBlue
        actionButton.layer.cornerRadius = 7
        
        actionButton.addTarget(self, action: #selector(dissmissVC), for: .touchUpInside)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            actionButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: padding/2),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding*2),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding*2),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    @objc func dissmissVC(){
        dismiss(animated:true)
    }
}
