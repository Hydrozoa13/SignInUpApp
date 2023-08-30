//
//  ProfileVC.swift
//  SignInUp App
//
//  Created by Евгений Лойко on 28.08.23.
//

import UIKit

class ProfileVC: UIViewController {

    private var userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func deleteAccAction() {
        UserDefaultsService.cleanUserDefaults()
        navigationController?.popToRootViewController(animated: true)
        if let destination = navigationController?.visibleViewController as? SignInVC {
            destination.emailTF.text = ""
            destination.passwordTF.text = ""
            destination.signInBtn.isEnabled = false
        } else { return }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    }
    
}
