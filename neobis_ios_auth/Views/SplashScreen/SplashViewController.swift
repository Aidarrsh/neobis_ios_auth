//
//  ViewController.swift
//  neobis_ios_auth
//
//  Created by Айдар Шарипов on 25/5/23.
//

import UIKit
import SnapKit

class SplashViewController : UIViewController {
    
    let mainView = SplashScreenView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        mainView.authorizeButton.addTarget(self, action: #selector(authorizeButtonPressed), for: .touchUpInside)
        mainView.beginButton.addTarget(self, action: #selector(beginButtonPressed), for: .touchUpInside)
    }
    
    func setupView(){
        view.addSubview(mainView)
        
        mainView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func beginButtonPressed() {
        let userViewModel = UserViewModel()
        let vc = RegistrationViewController(userViewModel: userViewModel)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func authorizeButtonPressed() {
        let userViewModel = UserViewModel()
        let vc = LoginViewController(userViewModel: userViewModel)
            
        navigationController?.pushViewController(vc, animated: true)
    }

}
