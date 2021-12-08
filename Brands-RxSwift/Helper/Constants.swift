//
//  Constants.swift
//  Rx-MVVM
//
//  Created by Ahmed Fathy on 03/12/2021.
//

import Foundation


let kUID = "uID"
let kBRANDS = "brands/"

func saveUser(uID: String?){
    UserDefaults.standard.set(uID, forKey: kUID)
    UserDefaults.standard.synchronize()
}


func returnUserId()-> String? {
    return UserDefaults.standard.string(forKey: kUID) as String?
}
