//
//  ChangeAccDataVC.swift
//  SignInUp App
//
//  Created by Евгений Лойко on 30.08.23.
//

import UIKit

class ChangeAccDataVC: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var emailErrorLbl: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passOverviewLbl: UILabel!
    @IBOutlet weak var passwordErrorLbl: UILabel!
    @IBOutlet var indicatorsViews: [UIView]!
    @IBOutlet weak var confirmPassTF: UITextField!
    @IBOutlet weak var confirmationErrorLbl: UILabel!
    @IBOutlet weak var saveDataBtn: UIButton!
    @IBOutlet weak var centerYConstraint: NSLayoutConstraint!
    
    private var isValidEmail = false { didSet { updateContinueBtnState() } }
    private var isConfirmedPass = false { didSet { updateContinueBtnState() } }
    private var passwordStrength: PasswordStrength = .veryWeak {
        didSet { updateContinueBtnState() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startKeyboardObserver()
    }
    
    @IBAction func emailTFAction(_ sender: UITextField) {
        if let email = sender.text,
           !email.isEmpty,
           VerificationService.isValidEmail(email: email) {
            isValidEmail = true
        } else { isValidEmail = false }
        emailErrorLbl.isHidden = isValidEmail
    }
    
    @IBAction func passwordTFAction(_ sender: UITextField) {
        if let passwordText = sender.text,
           !passwordText.isEmpty {
            passwordStrength = VerificationService.isValidPassword(pass: passwordText)
        } else { passwordStrength = .veryWeak }
        passwordErrorLbl.isHidden = passwordStrength != .veryWeak
        
        if passwordStrength == .strong {
            passOverviewLbl.isHidden = true
        }
        setupStrengthIndicators()
    }
    
    @IBAction func confirmPassTFAction(_ sender: UITextField) {
        if let confirmPassText = sender.text,
           !confirmPassText.isEmpty,
           let passwordText = passwordTF.text,
           !passwordText.isEmpty {
            isConfirmedPass = VerificationService.isConfirmedPass(pass1: passwordText,
                                                                  pass2: confirmPassText)
        } else { isConfirmedPass = false }
        confirmationErrorLbl.isHidden = isConfirmedPass
    }
    
    @IBAction func saveDataAction(_ sender: UIButton) {
        UserDefaultsService.cleanUserDefaults()
        if let email = emailTF.text,
           let password = passwordTF.text {
            let userModel = UserModel(name: nameTF.text,
                                      email: email, password: password)
            UserDefaultsService.saveUserModel(userModel: userModel)
        }
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileVC")
            as? ProfileVC
        {
            navigationController?.pushViewController(vc, animated: true)
            vc.navigationItem.hidesBackButton = true
        }
    }
    
    private func setupUI() {
        indicatorsViews.forEach { view in
            view.alpha = 0.2
            view.layer.cornerRadius = 7
        }
        saveDataBtn.isEnabled = false
        hideKeyboardWhenTappedAround()
    }
    
    private func setupStrengthIndicators() {
        indicatorsViews.enumerated().forEach { index, view in
            if index <= (passwordStrength.rawValue - 1) {
                view.alpha = 1
            } else {
                view.alpha = 0.2
            }
        }
    }
    
    private func updateContinueBtnState() {
        saveDataBtn.isEnabled = isValidEmail && isConfirmedPass
            && passwordStrength != .veryWeak
            && passwordStrength != .weak
    }
    
    private func startKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let _ = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        centerYConstraint.constant = -80
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        guard let _ = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        centerYConstraint.constant = 0
    }
}
