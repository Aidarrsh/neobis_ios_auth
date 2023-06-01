//
//  ResetView.swift
//  neobis_ios_auth
//
//  Created by Айдар Шарипов on 31/5/23.
//

import Foundation
import UIKit
import SnapKit

class ResetView : UIView, UITextFieldDelegate {
        
    let newPassword : UITextField = {
        let field = UITextField()
        field.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1.0)
        let placeholder = NSAttributedString(string: "Придумайте пароль", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 0.758, green: 0.758, blue: 0.758, alpha: 1), NSAttributedString.Key.font: UIFont(name: "GothamPro-Medium", size: 16)!])
        field.attributedPlaceholder = placeholder
        field.isSecureTextEntry = true
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
        field.leftView = leftView
        field.leftViewMode = .always
        field.layer.cornerRadius = 8
        field.returnKeyType = .search
        
        let button = UIButton(type: .custom)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.setImage(UIImage(named: "eye"), for: .normal)
        button.setImage(UIImage(named: "eye-disable"), for: .selected)
        button.frame = CGRect(x: CGFloat(field.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(toggleNewPasswordVisibility), for: .touchUpInside)
        field.rightView = button
        field.rightViewMode = .always

        return field
    }()
    
    let repeatPassword: UITextField = {
        let field = UITextField()
        field.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1.0)
        let placeholder = NSAttributedString(string: "Повторите пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.758, green: 0.758, blue: 0.758, alpha: 1), NSAttributedString.Key.font: UIFont(name: "GothamPro-Medium", size: 16)!])
        field.attributedPlaceholder = placeholder
        field.isSecureTextEntry = true
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
        field.leftView = leftView
        field.leftViewMode = .always
        field.layer.cornerRadius = 8
        field.returnKeyType = .search

        let button = UIButton(type: .custom)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.setImage(UIImage(named: "eye"), for: .normal)
        button.setImage(UIImage(named: "eye-disable"), for: .selected)
        button.frame = CGRect(x: CGFloat(field.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(toggleRepeatPasswordVisibility), for: .touchUpInside)
        field.rightView = button
        field.rightViewMode = .always

        return field
    }()
    
    let enterButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 93/255, green: 95/255, blue: 249/255, alpha: 1.0)
        button.layer.cornerRadius = 16
        let buttonTitle = "Далее"
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        
        button.contentVerticalAlignment = .center
        
        return button
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        newPassword.delegate = self
        repeatPassword.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backgroundColor = .white
        
        setupView()
        setupConstraints()
    }
    
    @objc func toggleNewPasswordVisibility(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        newPassword.isSecureTextEntry = !newPassword.isSecureTextEntry
    }
    
    @objc func toggleRepeatPasswordVisibility(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        repeatPassword.isSecureTextEntry = !repeatPassword.isSecureTextEntry
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.endEditing(true)
    }
    
    func setupView() {
        addSubview(newPassword)
        addSubview(repeatPassword)
        addSubview(enterButton)
    }
    
    func setupConstraints() {
        
        newPassword.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 128 / 812)
            make.centerX.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 60 / 812)
            make.width.equalTo(UIScreen.main.bounds.width * 335 / 375)
        }
        
        repeatPassword.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 212 / 812)
            make.centerX.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 60 / 812)
            make.width.equalTo(UIScreen.main.bounds.width * 335 / 375)
        }
        
        enterButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 440 / 812)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width * 335 / 375)
            make.height.equalTo(UIScreen.main.bounds.height * 65 / 812)
        }
    }
}

