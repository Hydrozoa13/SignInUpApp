//
//  TabBarController.swift
//  SignInUp App
//
//  Created by Евгений Лойко on 30.08.23.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        navigationItem.hidesBackButton = true
    }
}
