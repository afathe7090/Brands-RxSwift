//
//  FUser.swift
//  Rx-MVVM
//
//  Created by Ahmed Fathy on 03/12/2021.
//

import Firebase

class AuthFUser{
    
    static let shared = AuthFUser()
    
    func LoginUser(email: String ,password: String,completion: @escaping(AuthDataResult? ,Error?)->Void){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func creatUser(email: String , password: String,completion: @escaping(AuthDataResult? ,Error?)->Void ){
        Auth.auth().createUser(withEmail: email, password: password, completion: completion)
    }
    
}


