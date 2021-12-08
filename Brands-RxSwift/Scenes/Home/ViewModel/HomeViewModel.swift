//
//  HomeViewModel.swift
//  Rx-MVVM
//
//  Created by Ahmed Fathy on 03/12/2021.
//

import RxSwift
import RxCocoa
import Alamofire


class HomeViewModel {
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Proberties
    //----------------------------------------------------------------------------------------------------------------
    private weak var coordinator: HomeCoordinator?
    
    private let brandsSubject: PublishSubject<[BrandsData]> = PublishSubject()
    var brandsList: Observable<[BrandsData]> {
        return brandsSubject
    }
    let progressState: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Init
    //----------------------------------------------------------------------------------------------------------------
    init(withCoor coordinator: HomeCoordinator = HomeCoordinator()){
        self.coordinator = coordinator
    }
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Functions
    //----------------------------------------------------------------------------------------------------------------
    func fetchDataModel(){
        
        let url = Base_Url + kBRANDS
        progressState.accept(true)
        ApiService.Shared.fetchData(url: url, parms: nil, headers: Defult_header, method: .get) {[weak self] (category: Brands?, catregoryError: Brands?, error: Error?) in
            
            guard let self = self else{return}
            
            if let error = error {
                print(error.localizedDescription)
                self.progressState.accept(false)
                return}

            guard let brands = category?.data else {return}
            self.brandsSubject.onNext(brands)
            self.progressState.accept(false)
        }
    }
    
    
    func didSelectItemsTableView(_ data: BrandsData){
        self.coordinator?.gotToBrandsDetails(data)
    }
    
    
}

