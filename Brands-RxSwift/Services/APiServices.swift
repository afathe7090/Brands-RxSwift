//
//  APiServices.swift
//  Rx-MVVM
//
//  Created by Ahmed Fathy on 03/12/2021.
//

import Foundation
import Alamofire
import UIKit


let Base_Url = "https://api-mobilespecs.azharimm.site/v2/brands/"
let Defult_header:HTTPHeaders = ["Content-Type":"application/json"]


class ApiService {
    
    static let Shared = ApiService()
    
    func fetchData<T:Codable ,E:Codable>(url:String , parms:Parameters? , headers: HTTPHeaders?, method : HTTPMethod? , Compltion : @escaping((T?, E?, Error?)->Void)) {
        AF.request(url, method: method ?? .get, parameters: parms, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200 ..< 300)
            .responseJSON { (response) in
                switch response.result {
                case.success(_):
                    do {
                        guard let data = response.data else {return}
                        
                        let ResponseData = try JSONDecoder().decode(T?.self, from: data)
                        Compltion(ResponseData , nil , nil)
                        
                    }
                    catch let JsonErorr {
                        print(JsonErorr)
                    }
                case .failure(let error):
                    let StautsCode = response.response?.statusCode ?? 0
                    if StautsCode > 300 {
                        do {
                            guard let data = response.data else {return}
                            let responseError = try JSONDecoder().decode(E?.self, from: data)
                            Compltion(nil, responseError , nil)
                            
                        }
                        catch let JsonError {
                            print(JsonError)
                        }
                    }else{
                        Compltion(nil, nil , error)
                    }
                }
            }
    }
    
    

    
}
