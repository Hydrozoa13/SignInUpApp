//
//  SecretCodeVC.swift
//  SignInUp App
//
//  Created by Евгений Лойко on 26.08.23.
//

import UIKit

class SecretCodeVC: UIViewController {
    
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var secretCodeTF: UITextField!
    @IBOutlet weak var errorCodeLbl: UILabel!
    @IBOutlet weak var centerYConstraint: NSLayoutConstraint!
    
    var userModel: UserModel?
    let randomInt = Int.random(in: 100000...999999)
    var sleepTime = 3
    private var userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        hideKeyboardWhenTappedAround()
        startKeyboardObserver()
    }
    
    @IBAction func codeTFAction(_ sender: UITextField) {
        errorCodeLbl.isHidden = true
        guard let code = sender.text,
              !code.isEmpty,
              code == randomInt.description else {
            errorCodeLbl.isHidden = false
            sender.isUserInteractionEnabled = false
            errorCodeLbl.text = "Error: wrong code. Please wait \(sleepTime) seconds"
            
            let dispatchAfter = DispatchTimeInterval.seconds(sleepTime)
            let deadline = DispatchTime.now() + dispatchAfter
            DispatchQueue.main.asyncAfter(deadline: deadline) {
                sender.isUserInteractionEnabled = true
                self.errorCodeLbl.isHidden = true
                self.sleepTime *= 2
            }
            return
        }
        userDefaults.set(userModel?.email, forKey: "email")
        userDefaults.set(userModel?.password, forKey: "password")
        performSegue(withIdentifier: "goToWelcomeVC", sender: nil)
    }
    
    private func setupUI() {
        infoLbl.text = "Please enter code '\(randomInt)' from \(userModel?.email ?? "")"
        errorCodeLbl.isHidden = true
        navigationItem.hidesBackButton = true
    }
    
    private func startKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        centerYConstraint.constant -= keyboardSize.height / 2
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        centerYConstraint.constant += keyboardSize.height / 2
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? WelcomeVC else { return }
        destinationVC.userModel = userModel
    }
}
