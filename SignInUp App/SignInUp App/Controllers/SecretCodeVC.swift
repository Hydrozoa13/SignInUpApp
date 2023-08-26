//
//  SecretCodeVC.swift
//  SignInUp App
//
//  Created by Евгений Лойко on 26.08.23.
//

import UIKit

class SecretCodeVC: UIViewController {
    
    var userModel: UserModel?
    let randomInt = Int.random(in: 100000...999999)
    
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var secretCodeTF: UITextField!
    @IBOutlet weak var errorCodeLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        infoLbl.text = "Please enter code '\(randomInt)' from \(userModel?.email ?? "")"
        hideKeyboardWhenTappedAround()
        errorCodeLbl.isHidden = true
        navigationItem.leftBarButtonItem?.isHidden = true
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
