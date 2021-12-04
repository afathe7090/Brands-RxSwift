//
//  RegisterCoordinator.swift
//  Rx-MVVM
//
//  Created by Ahmed Fathy on 02/12/2021.
//

import UIKit

class RegisterCoordinator: Coordinator {
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Proberties
    //----------------------------------------------------------------------------------------------------------------
    private(set) var childCoordinators: [Coordinator] = []
    private var navigation: UINavigationController!
    private weak var parentCoordinator: LoginCoordinator?
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  init
    //----------------------------------------------------------------------------------------------------------------
    init(_ navigation: UINavigationController, parentCoor: LoginCoordinator? = nil){
        self.navigation = navigation
        self.parentCoordinator = parentCoor
    }
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Functions
    //----------------------------------------------------------------------------------------------------------------
    func start() {
        let viewModel = RegisterViewModel(withCoor: self)
        let registerController = RegisterViewController(viewModel: viewModel)
        navigation.pushViewController(registerController, animated: true)
    }
    
    
    
    func backToLoginViewController(){
        parentCoordinator?.shoudFinishCoordinator(childCoordinator: self)
    }
    
    
    
    func shouldFinsishCoordinator(coordinator:Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator in
            return coordinator === coordinator
        }){
            childCoordinators.remove(at: index)
            navigation.popViewController(animated: true)
        }
    }
    
    
    
}
