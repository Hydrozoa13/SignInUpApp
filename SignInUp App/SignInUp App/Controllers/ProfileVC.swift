//
//  ProfileVC.swift
//  SignInUp App
//
//  Created by Евгений Лойко on 28.08.23.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var helloLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    
    var userModel = UserDefaultsService.getUserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func deleteAccAction() {
        UserDefaultsService.cleanUserDefaults()
        navigationController?.popToRootViewController(animated: true)
        if let destination = navigationController?.visibleViewController as? SignInVC {
            destination.emailTF.text = ""
            destination.passwordTF.text = ""
            destination.signInBtn.isEnabled = false
            UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        } else { return }
    }
    
    private func setupUI() {
        helloLbl.text = "Hello \(userModel?.name ?? "")!"
        emailLbl.text = "Your email: \(userModel?.email ?? "")"
    }
}
