//
//  EmailViewController.swift
//  neobis_ios_auth
//
//  Created by Айдар Шарипов on 6/6/23.
//

import Foundation
import UIKit
import SnapKit

class EmailViewController : UIViewController {

    let mainView = EmailView()
    var userViewModel = UserViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        title = "Сброс пароля"

        let backButton = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backPressed))
        self.navigationItem.leftBarButtonItem = backButton
        
        mainView.enterButton.addTarget(self, action: #selector(enterPressed), for: .touchUpInside)
    }
    
    @objc func enterPressed() {
        guard let email = mainView.loginField.text else {
            // Show error message to user
            print("Email or password is empty.")
            return
        }
        
        userViewModel.forgotPassword(email: email)
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
}
