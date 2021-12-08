//
//  BrandsDetailsViewModel.swift
//  Rx-MVVM
//
//  Created by Ahmed Fathy on 04/12/2021.
//

import Foundation
import RxSwift
import RxCocoa

class BrandsDetailsViewModel {
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Proberties
    //----------------------------------------------------------------------------------------------------------------
    private weak var coordinator: BrandsDetailsCoordinator?
    private var dataCommingFromHome: BrandsData?
    private let detailsSubject: PublishSubject<BrandsDetails> = PublishSubject()
    
    var detailsList : Observable<[Phone]>{
        return detailsSubject.map { brandDetails in
            return brandDetails.data.phones
        }
    }
    
    var titleObservable: Observable<String> {
        return detailsSubject.map { brandsDetails in
            return brandsDetails.data.title
        }
    }
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Init
    //----------------------------------------------------------------------------------------------------------------
    init(withCoor coordinator: BrandsDetailsCoordinator = BrandsDetailsCoordinator()
         , withDataComming: BrandsData? = nil){
        
        self.coordinator = coordinator
        self.dataCommingFromHome = withDataComming
    }
    

    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Functions
    //----------------------------------------------------------------------------------------------------------------

    func fetchDataFromBrands(){
        guard let dataCommingFromHome = dataCommingFromHome else { return }
        let url = Base_Url + kBRANDS + dataCommingFromHome.brand_slug
        ApiService.Shared.fetchData(url: url, parms: nil, headers: Defult_header, method: .get) {( details: BrandsDetails?, errorDetail: BrandsDetails?, error: Error? )in
            if let error = error {print(error.localizedDescription)
                return
            }
            guard let details = details else { return }
            self.detailsSubject.onNext(details)
        }
        
    }
    
    
    func goToDetailsPhoneResult(_ brands: Phone?){
        coordinator?.goToBrandsPhoneView(brands)
    }
    
    
    func goToHome(){
        coordinator?.returnToHome()
    }
    
    
    
}
