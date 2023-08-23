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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
