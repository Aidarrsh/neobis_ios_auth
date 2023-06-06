//
//  LoginViewController.swift
//  neobis_ios_auth
//
//  Created by Айдар Шарипов on 26/5/23.
//

import Foundation
import UIKit
import SnapKit

class LoginViewController : UIViewController, LoginViewModelDelegate {
    let mainView = LoginScreenView()
    var userViewModel: UserViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        userViewModel = UserViewModel(loginDelegate: self)
        
        let backButton = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backPressed))
        self.navigationItem.leftBarButtonItem = backButton
        
        mainView.enterButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        mainView.resetPasswordButton.addTarget(self, action: #selector(resetPasswordPressed), for: .touchUpInside)
    }
    
    @objc func loginPressed() {
        guard let email = mainView.loginField.text, let password = mainView.passwordField.text else {
            // Show error message to user
            print("Email or password is empty.")
            return
        }
        
        userViewModel.loginUser(email: email, password: password)
    }

    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func resetPasswordPressed() {
        let vc = ResetViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupView(){
        view.addSubview(mainView)
        mainView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }

    // LoginViewModelDelegate methods
    func didLogin(user: TokenObtainPair) {
        print("Successfully logged in as \(user)")
    }
    
    func didFail(with error: Error) {
        print("Failed to login: \(error)")
    }
}
