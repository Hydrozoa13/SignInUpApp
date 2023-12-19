//
//  EyeButton.swift
//  SignInUp App
//
//  Created by Евгений Лойко on 31.08.23.
//

import UIKit

final class EyeButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupEyeButton()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupEyeButton() {
        setImage(UIImage(systemName: "eye.slash"), for: .normal)
        tintColor = .systemIndigo
        widthAnchor.constraint(equalToConstant: 40).isActive = true
        isEnabled = false
    }
}
