//
//  WelcomeVC.swift
//  SignInUp App
//
//  Created by Евгений Лойко on 27.08.23.
//

import UIKit

class WelcomeVC: UIViewController {

    @IBOutlet weak var infoLbl: UILabel!
    
    var userModel: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func continueBtnAction() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func setupUI() {
        navigationItem.hidesBackButton = true
        infoLbl.text = "\(userModel?.name ?? "") to the App"
    }
}
