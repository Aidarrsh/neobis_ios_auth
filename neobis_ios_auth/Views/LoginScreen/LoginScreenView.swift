//
//  LoginScreenView.swift
//  neobis_ios_auth
//
//  Created by Айдар Шарипов on 26/5/23.
//

import Foundation
import UIKit
import SnapKit

class LoginScreenView : UIView, UITextFieldDelegate {
    
    let smileImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "smile")
        
        return image
    }()
    
    let loginField : UITextField = {
        let field = UITextField()
        field.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1.0)
        let placeholder = NSAttributedString(string: "Электронная почта", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 0.758, green: 0.758, blue: 0.758, alpha: 1), NSAttributedString.Key.font: UIFont(name: "GothamPro-Medium", size: 16)!])
        field.attributedPlaceholder = placeholder
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
        field.leftView = leftView
        field.leftViewMode = .always
        field.layer.cornerRadius = 8
        field.returnKeyType = .search

        return field
    }()
    
    let passwordField: UITextField = {
        let field = UITextField()
        field.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1.0)
        let placeholder = NSAttributedString(string: "Пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.758, green: 0.758, blue: 0.758, alpha: 1), NSAttributedString.Key.font: UIFont(name: "GothamPro-Medium", size: 16)!])
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
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        field.rightView = button
        field.rightViewMode = .always

        return field
    }()
    
    let enterButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1.0)
        button.layer.cornerRadius = 16
        let buttonTitle = "Войти"
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(UIColor(red: 156/255, green: 164/255, blue: 171/255, alpha: 1.0), for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        
        button.contentVerticalAlignment = .center
        
        return button
    }()
    
    let resetPasswordButton : UIButton = {
        let button = UIButton()
        let buttonTitle = "Забыли пароль?"
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        button.contentVerticalAlignment = .center
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loginField.delegate = self
        passwordField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backgroundColor = .white
        
        setupView()
        setupConstraints()
    }
    
    @objc func togglePasswordVisibility(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        passwordField.isSecureTextEntry = !passwordField.isSecureTextEntry
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.endEditing(true)
    }
    
    func setupView() {
        addSubview(smileImage)
        addSubview(loginField)
        addSubview(passwordField)
        addSubview(enterButton)
        addSubview(resetPasswordButton)
    }
    
    func setupConstraints() {
        smileImage.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 76 / 812)
            make.centerX.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 120 / 812)
            make.width.equalTo(UIScreen.main.bounds.height * 120 / 812)
        }
        
        loginField.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 246 / 812)
            make.centerX.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 60 / 812)
            make.width.equalTo(UIScreen.main.bounds.width * 335 / 375)
        }
        
        passwordField.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 320 / 812)
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
        
        resetPasswordButton.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().inset(UIScreen.main.bounds.height * 69 / 812)
            make.width.equalTo(UIScreen.main.bounds.width * 335 / 375)
            make.centerX.equalToSuperview()
        }
    }
}
