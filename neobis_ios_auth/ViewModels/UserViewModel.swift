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

protocol PasswordResetViewModelDelegate: AnyObject {
    func didForgotPassword(user: ForgotPassword)
    func didConfirmForgotPassword(user: ForgotPasswordConfirm)
    func didFail(with error: Error)
}

class UserViewModel {
    weak var registrationDelegate: RegistrationViewModelDelegate?
    weak var loginDelegate: LoginViewModelDelegate?
    weak var passwordResetDelegate: PasswordResetViewModelDelegate?

    let apiService = APIService()

    init(registrationDelegate: RegistrationViewModelDelegate? = nil,
         loginDelegate: LoginViewModelDelegate? = nil,
         passwordResetDelegate: PasswordResetViewModelDelegate? = nil) {
        self.registrationDelegate = registrationDelegate
        self.loginDelegate = loginDelegate
        self.passwordResetDelegate = passwordResetDelegate
    }

    func registerUser(email: String, password: String, password2: String) {
        let parameters: [String: Any] = ["email": email, "password": password, "password2": password2]
        
        apiService.post(endpoint: "/register", parameters: parameters) { [weak self] (result) in
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
}
