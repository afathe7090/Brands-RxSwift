//
//  LoginViewModel.swift
//  Rx-MVVM
//
//  Created by Ahmed Fathy on 02/12/2021.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel{
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Proberties
    //----------------------------------------------------------------------------------------------------------------
    private weak var coordinator: LoginCoordinator?
    
    let emailObservable: BehaviorRelay<String> = BehaviorRelay(value: "")
    let passwordObservable: BehaviorRelay<String> = BehaviorRelay(value: "")
    let startHud: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    private let bag = DisposeBag()
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Init
    //----------------------------------------------------------------------------------------------------------------
    init(withCoor coordinator: LoginCoordinator = LoginCoordinator()){
        self.coordinator = coordinator
    }
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Functions
    //----------------------------------------------------------------------------------------------------------------
    
    
    func emailValid()-> Observable<Bool>{
        return emailObservable.map { email in
            return email.count >= 6
        }
    }
    
    func passwordValid()-> Observable<Bool>{
        return passwordObservable.map { password in
            return password.count >= 6
        }
    }
    
    
    func emailAndPasswordValid()-> Observable<Bool> {
        return Observable.combineLatest(emailValid().startWith(false), passwordValid().startWith(false)).map { (emailState ,passwordState) in
            return emailState && passwordState
        }
    }
    
    
    func userSignIn(){
        startHud.accept(true)
        AuthFUser.shared.LoginUser(email: emailObservable.value, password: passwordObservable.value) { result, error in
            self.startHud.accept(false)
            if let error = error {
                print(error.localizedDescription)
                return
            }else{
                let uid = result?.user.uid
                saveUser(uID: uid)
                self.coordinator?.goToHomePageAfterSignIn()
            }
        }
    }
    
    
    func goToRigesterPageView(){
        coordinator?.goToRegisterPageView()
    }
    
    
}

