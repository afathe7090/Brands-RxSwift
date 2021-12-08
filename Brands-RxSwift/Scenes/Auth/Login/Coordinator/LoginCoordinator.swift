//
//  LoginCoordinator.swift
//  Rx-MVVM
//
//  Created by Ahmed Fathy on 02/12/2021.
//

import UIKit

class LoginCoordinator: Coordinator {
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Proberties
    //----------------------------------------------------------------------------------------------------------------
    private(set) var childCoordinators: [Coordinator] = []
    private var rootViewController: UINavigationController!
    
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Init
    //----------------------------------------------------------------------------------------------------------------
    init(_ navigationView: UINavigationController = UINavigationController()){
        self.rootViewController  = navigationView
    }
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Helper Functions
    //----------------------------------------------------------------------------------------------------------------
    
    func start() {
        let viewModel = LoginViewModel(withCoor: self)
        let loginViewController = LoginViewController(viewModel: viewModel)
        rootViewController.navigationBar.tintColor = .white
        rootViewController.setViewControllers([loginViewController], animated: true)
    }
    
    

    func goToRegisterPageView(){
        let registerCoordinator = RegisterCoordinator(rootViewController, parentCoor: self)
        childCoordinators.append(registerCoordinator)
        registerCoordinator.start()
    }
    
    
    func goToHomePageAfterSignIn(){
        let homeCoordinator = HomeCoordinator(with: rootViewController,with: self)
        childCoordinators.append(homeCoordinator)
        homeCoordinator.start()
        
    }
    
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Did Finish Coordinator
    //----------------------------------------------------------------------------------------------------------------
    func shoudFinishCoordinator(childCoordinator: Coordinator){
        if let index = childCoordinators.firstIndex(where: {coordinator in
            return coordinator === coordinator
        }){
            childCoordinators.remove(at: index)
            rootViewController.popViewController(animated: true)
        }
        
    }
    
}
