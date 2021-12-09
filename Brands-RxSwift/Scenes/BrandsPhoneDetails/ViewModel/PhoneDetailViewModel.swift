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
    private var phoneDetails = PublishSubject<BrandsPhone>()
    
    var imageCollection: Observable<[String]> {
        return phoneDetails.asObserver().map { phone in
            return phone.data.phone_images
        }
    }
    
    var phoneDetail: Observable<BrandsPhoneDetails> {
        return phoneDetails.asObservable().map { phone in
            return phone.data
        }
    }
    
    
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
    
    
    // finish Coordinator from Memory after deInit
    func didFinishDeinit(){
        coordinator?.didFinishView()
    }
    
    
    // fetch Phone Data From Api
    func fetchDataAPI(){
        guard let urlDetailKey = brandsCom?.slug else{ return }
        let url = Base_Url + urlDetailKey
        
        ApiService.Shared.fetchData(url: url, parms: nil, headers: Defult_header, method: .get) {( phone: BrandsPhone?, phoneError: BrandsPhone?, error: Error? )in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let phone = phone {
                self.phoneDetails.onNext(phone)
            }
        }
    }
    
    
    
}
