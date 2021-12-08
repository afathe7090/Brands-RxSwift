//
//  BrandsPhoneDetailViewModel.swift
//  Brands-RxSwift
//
//  Created by Ahmed Fathy on 08/12/2021.
//

import Foundation
import RxSwift
import RxCocoa

class PhoneDetailViewModel{
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Proberties
    //----------------------------------------------------------------------------------------------------------------
    private weak var coordinator: PhoneDetailCoordinator?
    private var brandsCom: Phone?
    private var phoneDetail = PublishSubject<BrandsPhone>()
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Init
    //----------------------------------------------------------------------------------------------------------------
    init(withCoor coordinator: PhoneDetailCoordinator = PhoneDetailCoordinator()
         , brands: Phone? = nil){
        
        self.coordinator = coordinator
        self.brandsCom = brands
    }
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Helper Functions
    //----------------------------------------------------------------------------------------------------------------
    
    
    func didFinishDeinit(){
        coordinator?.didFinishView()
    }
    
    
    func fetchDataAPI(){
        guard let urlDetailKey = brandsCom?.slug else{ return }
        
        print(urlDetailKey)
        let url = Base_Url + urlDetailKey
        print("============ url")
        
        ApiService.Shared.fetchData(url: url, parms: nil, headers: Defult_header, method: .get) {( phone: BrandsPhone?, phoneError: BrandsPhone?, error: Error? )in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let phone = phone {
                print(phone)
            }
            
        }
        
        
    }
    
    
    
}
