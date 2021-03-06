//
//  BrandsPhoneDetailCoordinator.swift
//  Brands-RxSwift
//
//  Created by Ahmed Fathy on 08/12/2021.
//

import Foundation
import UIKit


class PhoneDetailCoordinator: Coordinator{
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Proberties
    //----------------------------------------------------------------------------------------------------------------
    private (set) var childCoordinators: [Coordinator] = []
    private var navigation: UINavigationController?
    private var brands: Phone?
    private weak var parentCoordinator: BrandsDetailsCoordinator?

    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Init
    //----------------------------------------------------------------------------------------------------------------
    init(withNav navigation: UINavigationController = UINavigationController()
         ,parent: BrandsDetailsCoordinator = BrandsDetailsCoordinator()
         ,brands: Phone? = nil){
         
        self.parentCoordinator = parent
        self.navigation = navigation
        self.brands = brands
    }
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Functions
    //----------------------------------------------------------------------------------------------------------------
    //start Coordinator
    func start() {
        let viewModel = PhoneDetailViewModel(withCoor: self, brands: brands)
        let phoneVC = PhoneDetailsViewController(with: viewModel)
        self.navigation?.present(phoneVC, animated: true, completion: nil)
    }
    
    // finish Coordinator
    func didFinishView(){
        parentCoordinator?.didFinishedCoordinator(coordinator: self)
    }
}
