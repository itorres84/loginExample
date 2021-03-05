//
//  UserRepository.swift
//  Login
//
//  Created by Israel Torres Alvarado on 02/03/21.
//

import Foundation

class UserRepository {
    
    let user = "israeltorres27@gmail.com"
    let password = "1234567890"
    
    func login(email: String, passwordView: String) -> Bool {
        
        
        //Guard
        guard email == user, passwordView == password else {
            return false
        }
        
        return true
        
        //IF
//        if email.elementsEqual(user), passwordView.elementsEqual(password) {
//           return true
//        } else {
//           return false
//        }
        
    }
    
}
