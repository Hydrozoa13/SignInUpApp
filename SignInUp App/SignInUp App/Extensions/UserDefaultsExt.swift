//
//  UserDefaultsExt.swift
//  SignInUp App
//
//  Created by Евгений Лойко on 30.08.23.
//

import Foundation

extension UserDefaults {
    
    enum Keys: String, CaseIterable {
        case email
        case password
        case name
    }

    func reset() {
        let allCases = Keys.allCases
        allCases.forEach { removeObject(forKey: $0.rawValue) }
    }
}
