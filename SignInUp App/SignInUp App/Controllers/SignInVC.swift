//
//  SignInVC.swift
//  SignInUp App
//
//  Created by Евгений Лойко on 23.08.23.
//

import UIKit

class SignInVC: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var constraintY: NSLayoutConstraint!
    
    private var emailValidated = false { didSet {updateSignInBtnState()} }
    private var passwordValidated = false { didSet {updateSignInBtnState()} }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        if let _ = UserDefaults.standard.object(forKey: "isLoggedIn") as? Bool {
            goToTabBarController()
        } else { return }
    }
    
    @IBAction func emailTFAction(_ sender: UITextField) {
        if let email = sender.text, !email.isEmpty,
           email == UserDefaultsService.getUserModel()?.email {
            emailValidated = true
        } else { emailValidated = false }
    }
    
    @IBAction func passwordTFAction(_ sender: UITextField) {
        if let password = sender.text, !password.isEmpty,
           password == UserDefaultsService.getUserModel()?.password {
            passwordValidated = true
        } else { passwordValidated = false }
        errorLbl.isHidden = passwordValidated && emailValidated
    }
    
    @IBAction func unwindToSignInVC(_ unwindSegue: UIStoryboardSegue) {
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        emailTF.text = UserDefaultsService.getUserModel()?.email
        emailValidated = true
        passwordTF.text = ""
        signInBtn.isEnabled = false
    }
    
    @IBAction func signInAction() {
        goToTabBarController()
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
    }
    
    private func goToTabBarController() {
        let storyboard = UIStoryboard(name: "MainStoryboard", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "TabBarController")
                as? TabBarController
        else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupUI() {
        errorLbl.isHidden = true
        signInBtn.isEnabled = false
        hideKeyboardWhenTappedAround()
    }
    
    private func updateSignInBtnState() {
        signInBtn.isEnabled = emailValidated && passwordValidated
        errorLbl.isHidden = true
    }
}
