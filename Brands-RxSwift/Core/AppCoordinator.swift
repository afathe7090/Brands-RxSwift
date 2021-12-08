//
//  AppCoordinator.swift
//  Rx-MVVM
//
//  Created by Ahmed Fathy on 02/12/2021.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] {get}
    func start()
}


class AppCoordinator: Coordinator{
    
    private(set) var childCoordinators: [Coordinator] = []
    private var window: UIWindow?
    private let navigation = UINavigationController()
    
    init(_ window: UIWindow = UIWindow()){
        self.window = window
    }
    
    func start() {
        if returnUserId() != nil {
            // go to home
            let homeViewController = HomeCoordinator(with: navigation)
            childCoordinators.append(homeViewController)
            homeViewController.start()
        }else{
            // go to Login
            let loginCordinator = LoginCoordinator(navigation)
            childCoordinators.append(loginCordinator)
            loginCordinator.start()
        }
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
    
}

