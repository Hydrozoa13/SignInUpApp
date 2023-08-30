//
//  CreateAccountVC.swift
//  SignInUp App
//
//  Created by Евгений Лойко on 23.08.23.
//

import UIKit

class CreateAccountVC: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var errorEmailLbl: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var errorPasswordLbl: UILabel!
    @IBOutlet var passwordIndicatorsViews: [UIView]!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var errorPasswordConfirmLbl: UILabel!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private var isValidEmail = false { didSet { updateContinueBtnState() } }
    private var isConfirmedPass = false { didSet { updateContinueBtnState() } }
    private var passwordStrength: PasswordStrength = .veryWeak {
        didSet { updateContinueBtnState() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func signInAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func emailTFAction(_ sender: UITextField) {
        if let email = sender.text,
           !email.isEmpty,
           VerificationService.isValidEmail(email: email) {
            isValidEmail = true
        } else { isValidEmail = false }
        
        errorEmailLbl.isHidden = isValidEmail
    }
    
    @IBAction func passwordTFAction(_ sender: UITextField) {
        if let passwordText = sender.text,
           !passwordText.isEmpty {
            passwordStrength = VerificationService.isValidPassword(pass: passwordText)
        } else { passwordStrength = .veryWeak }
        errorPasswordLbl.isHidden = passwordStrength != .veryWeak
        
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
        
        errorPasswordConfirmLbl.isHidden = isConfirmedPass
    }
    
    @IBAction func continueAction() {
        if let email = emailTF.text,
           let password = passwordTF.text {
            let userModel = UserModel(name: nameTF.text,
                                      email: email, password: password)
            performSegue(withIdentifier: "goToSecretCodeVC", sender: userModel)
        }
    }
    
    private func setupUI() {
        errorEmailLbl.isHidden = true
        errorPasswordLbl.isHidden = true
        passwordIndicatorsViews.forEach { view in
            view.alpha = 0.2
            view.layer.cornerRadius = 7
        }
        errorPasswordConfirmLbl.isHidden = true
        continueBtn.isEnabled = false
        hideKeyboardWhenTappedAround()
        startKeyboardObserver()
        navigationItem.hidesBackButton = true
    }
    
    private func setupStrengthIndicators() {
        passwordIndicatorsViews.enumerated().forEach { index, view in
            if index <= (passwordStrength.rawValue - 1) {
                view.alpha = 1
            } else {
                view.alpha = 0.2
            }
        }
    }
    
    private func updateContinueBtnState() {
        continueBtn.isEnabled = isValidEmail && isConfirmedPass
            && passwordStrength != .veryWeak
            && passwordStrength != .weak
    }
    
    private func startKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func keyboardWillHide() {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? SecretCodeVC,
              let userModel = sender as? UserModel else { return }
        destinationVC.userModel = userModel
    }
}
