//
//  HomeCoordinator.swift
//  Rx-MVVM
//
//  Created by Ahmed Fathy on 03/12/2021.
//

import UIKit

class HomeCoordinator: Coordinator{
    
    private(set) var childCoordinators: [Coordinator] = []
    private var navigation: UINavigationController!
    private weak var parentCoordinator: LoginCoordinator?
    
    init(with navigation: UINavigationController = UINavigationController()
         ,with parentCoordinator: LoginCoordinator? = nil) {
        self.navigation = navigation
        self.parentCoordinator = parentCoordinator
    }
    
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Helper Functions
    //----------------------------------------------------------------------------------------------------------------
    func start() {
        let viewModel = HomeViewModel(withCoor: self)
        let homeVC = HomeViewController(viewModel: viewModel)
        
        if parentCoordinator != nil {
            homeVC.modalPresentationStyle = .fullScreen
            navigation.setViewControllers([homeVC], animated: true)
        }else{
            navigation.setViewControllers([homeVC], animated: true)
        }
       
    }
    
    func didFinshCoordinator(coordinator: Coordinator){
        if let index = childCoordinators.firstIndex(where: { coordinator in
            return coordinator === coordinator
        }){
            self.childCoordinators.remove(at: index)
            navigation.popViewController(animated: true)
        }
    }
    
    
    func gotToBrandsDetails(_ data: BrandsData){
        let brandsCoordinator = BrandsDetailsCoordinator(with: navigation, withCoor: self, withData: data)
        self.childCoordinators.append(brandsCoordinator)
        brandsCoordinator.start()
    }
    
    
    
}
