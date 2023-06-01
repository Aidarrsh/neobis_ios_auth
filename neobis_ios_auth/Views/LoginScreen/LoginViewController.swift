//
//  LoginViewController.swift
//  neobis_ios_auth
//
//  Created by Айдар Шарипов on 26/5/23.
//

import Foundation
import UIKit
import SnapKit

class LoginViewController : UIViewController {
    
    let mainView = LoginScreenView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
//        title = "Регистрация"
        
        
        let backButton = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backPressed))
        self.navigationItem.leftBarButtonItem = backButton
        
        mainView.resetPasswordButton.addTarget(self, action: #selector(resetPasswordPressed), for: .touchUpInside)
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
}
