//
//  BrandsDetailsCoordinator.swift
//  Rx-MVVM
//
//  Created by Ahmed Fathy on 04/12/2021.
//

import UIKit
import RxSwift
import RxCocoa

class BrandsDetailsCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    private var navigation: UINavigationController!
    private weak var parentCoordinator: HomeCoordinator?
    private var dataBack: BrandsData?
    
    
    init(with navigation: UINavigationController = UINavigationController()
         , withCoor coordinator: HomeCoordinator = HomeCoordinator ()
         ,withData: BrandsData? = nil){
        
        self.navigation = navigation
        self.parentCoordinator = coordinator
        self.dataBack = withData
    }
    
    
    func start() {
        let viewModel = BrandsDetailsViewModel(withCoor: self, withDataComming: dataBack)
        let brandsVC = BrandsDetailsViewController(viewModel: viewModel)
        self.navigation.pushViewController(brandsVC, animated: true)
    }
    
    func goToBrandsPhoneView(_ brands: Phone?){
        let coordintor = PhoneDetailCoordinator(withNav: navigation, parent: self, brands: brands)
        childCoordinators.append(coordintor)
        coordintor.start()
    }
    
    
    
    func didFinishedCoordinator(coordinator: Coordinator){
        if let index = childCoordinators.firstIndex(where: { coordinstor in
            return coordinator === coordinator
        }){
            childCoordinators.remove(at: index)
            self.navigation.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    func returnToHome(){
        parentCoordinator?.didFinshCoordinator(coordinator: self)
    }
    
}
