//
//  RegistrationViewController.swift
//  neobis_ios_auth
//
//  Created by Айдар Шарипов on 29/5/23.
//

import Foundation
import UIKit
import SnapKit

class RegistrationViewController : UIViewController, RegistrationViewModelDelegate {

    let mainView = RegistrationScreenView()
    var userViewModel: UserViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        userViewModel = UserViewModel(registrationDelegate: self)
        title = "Регистрация"

        let backButton = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backPressed))
        self.navigationItem.leftBarButtonItem = backButton
    }

    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }

    func setupView() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - RegistrationViewModelDelegate Methods

    func didRegister(user: Register) {
        // Handle successful registration here.
        print("Successfully registered user with email: \(user.email)")
    }

    func didFail(with error: Error) {
        // Handle failure in registration here.
        print("Error in registration: \(error.localizedDescription)")
    }
}
