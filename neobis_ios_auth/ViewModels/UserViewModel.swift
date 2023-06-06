//
//  LoginViewModel.swift
//  neobis_ios_auth
//
//  Created by Айдар Шарипов on 28/5/23.
//

import Foundation
import UIKit
import SnapKit

protocol RegistrationViewModelDelegate: AnyObject {
    func didRegister(user: Register)
    func didFail(with error: Error)
}

protocol LoginViewModelDelegate: AnyObject {
    func didLogin(user: TokenObtainPair)
    func didFail(with error: Error)
}

protocol ForgotPasswordViewModelDelegate: AnyObject {
    func didForgotPassword(user: ForgotPassword)
    func didFail(with error: Error)
}

protocol ConfirmPasswordViewModelDelegate: AnyObject {
    func didConfirmForgotPassword(user: ForgotPasswordConfirm)
    func didFail(with error: Error)
}

protocol UserViewModelProtocol: AnyObject {
    var registrationDelegate: RegistrationViewModelDelegate? { get set }
    var loginDelegate: LoginViewModelDelegate? { get set }
    var forgotPasswordDelegate: ForgotPasswordViewModelDelegate? { get set }
    var confirmPasswordDelegate: ConfirmPasswordViewModelDelegate? { get set }
    
    func registerUser(email: String, password: String, password2: String)
    func loginUser(email: String, password: String)
    func forgotPassword(email: String)
    func confirmForgotPassword(email: String, newPassword: String, activationCode: String)
}

class UserViewModel: UserViewModelProtocol {
    weak var registrationDelegate: RegistrationViewModelDelegate?
    weak var loginDelegate: LoginViewModelDelegate?
    weak var forgotPasswordDelegate: ForgotPasswordViewModelDelegate?
    weak var confirmPasswordDelegate: ConfirmPasswordViewModelDelegate?
    
    let apiService = APIService()
    
    init(registrationDelegate: RegistrationViewModelDelegate? = nil,
         loginDelegate: LoginViewModelDelegate? = nil,
         forgotPasswordDelegate: ForgotPasswordViewModelDelegate? = nil,
         confirmPasswordDelegate: ConfirmPasswordViewModelDelegate? = nil) {
        self.registrationDelegate = registrationDelegate
        self.loginDelegate = loginDelegate
        self.confirmPasswordDelegate = confirmPasswordDelegate
        self.forgotPasswordDelegate = forgotPasswordDelegate
    }
    
    func registerUser(email: String, password: String, password2: String) {
        let parameters: [String: Any] = ["email": email, "password": password, "password2": password2]
        
        apiService.post(endpoint: "register/", parameters: parameters) { [weak self] (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(Register.self, from: data)
                    DispatchQueue.main.async {
                        self?.registrationDelegate?.didRegister(user: response)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self?.registrationDelegate?.didFail(with: error)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.registrationDelegate?.didFail(with: error)
                }
            }
        }
    }
    
    func loginUser(email: String, password: String) {
        let parameters: [String: Any] = ["email": email, "password": password]
        
        apiService.post(endpoint: "login/", parameters: parameters) { [weak self] (result) in
            switch result {
            case .success(let data):
                let dataString = String(data: data, encoding: .utf8)
                print("Data received: \(dataString ?? "nil")")
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(TokenObtainPair.self, from: data)
                    DispatchQueue.main.async {
                        self?.loginDelegate?.didLogin(user: response)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self?.loginDelegate?.didFail(with: error)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.loginDelegate?.didFail(with: error)
                }
            }
        }
    }
    
    func forgotPassword(email: String) {
        let parameters: [String: Any] = ["email": email]
        
        apiService.post(endpoint: "forgot_password/", parameters: parameters) { [weak self] (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(ForgotPassword.self, from: data)
                    DispatchQueue.main.async {
                        self?.forgotPasswordDelegate?.didForgotPassword(user: response)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self?.forgotPasswordDelegate?.didFail(with: error)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.forgotPasswordDelegate?.didFail(with: error)
                }
            }
        }
    }
    
    func confirmForgotPassword(email: String, newPassword: String, activationCode: String) {
        let parameters: [String: Any] = ["email": email, "new_password": newPassword, "activation_code": activationCode]
        
        apiService.post(endpoint: "forgot_password_confirm/", parameters: parameters) { [weak self] (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(ForgotPasswordConfirm.self, from: data)
                    DispatchQueue.main.async {
                        self?.confirmPasswordDelegate?.didConfirmForgotPassword(user: response)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self?.confirmPasswordDelegate?.didFail(with: error)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.confirmPasswordDelegate?.didFail(with: error)
                }
            }
        }
    }
    
}
