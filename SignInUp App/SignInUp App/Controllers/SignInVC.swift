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
    
    var userModel: UserModel?
    private var emailValidated = false { didSet {updateSignInBtnState()} }
    private var passwordValidated = false { didSet {updateSignInBtnState()} }
    private var userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func emailTFAction(_ sender: UITextField) {
        if let email = sender.text, !email.isEmpty,
           email == userDefaults.object(forKey: "email") as? String {
            emailValidated = true
        } else { emailValidated = false }
    }
    
    @IBAction func passwordTFAction(_ sender: UITextField) {
        if let password = sender.text, !password.isEmpty,
           password == userDefaults.object(forKey: "password") as? String {
            passwordValidated = true
        } else { passwordValidated = false }
        errorLbl.isHidden = passwordValidated && emailValidated
    }
    
    private func setupUI() {
        errorLbl.isHidden = true
        signInBtn.isEnabled = false
        hideKeyboardWhenTappedAround()
    }
    
    private func updateSignInBtnState() {
        signInBtn.isEnabled = emailValidated && passwordValidated
    }
}
