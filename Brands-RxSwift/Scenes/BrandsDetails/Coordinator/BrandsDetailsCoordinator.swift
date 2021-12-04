//
//  BrandsDetailsCoordinator.swift
//  Rx-MVVM
//
//  Created by Ahmed Fathy on 04/12/2021.
//

import UIKit

class BrandsDetailsCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    private var navigation: UINavigationController!
    private weak var parentCoordinator: HomeCoordinator?
    private var dataBack: Datum?
    
    
    init(with navigation: UINavigationController, withCoor coordinator: HomeCoordinator ,withData: Datum? = nil){
        self.navigation = navigation
        self.parentCoordinator = coordinator
        self.dataBack = withData
    }
    
    
    func start() {
        let viewModel = BrandsDetailsViewModel(withCoor: self, withDataComming: dataBack)
        let brandsVC = BrandsDetailsViewController(viewModel: viewModel)
        self.navigation.pushViewController(brandsVC, animated: true)
    }
    
    
    func returnToHome(){
        parentCoordinator?.didFinshCoordinator(coordinator: self)
    }
    
}
