//
//  RegisterViewModel.swift
//  Rx-MVVM
//
//  Created by Ahmed Fathy on 02/12/2021.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit


class RegisterViewModel {
    
    private weak var coordinator: RegisterCoordinator?
    
    let emailObservable: BehaviorRelay<String> = BehaviorRelay(value: "")
    let passwordObservable: BehaviorRelay<String> = BehaviorRelay(value: "")
    let re_passwordObservable: BehaviorRelay<String> = BehaviorRelay(value: "")
    let startHud: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    
    private let bag = DisposeBag()
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Init
    //----------------------------------------------------------------------------------------------------------------
    init(withCoor coordinator: RegisterCoordinator){
        self.coordinator = coordinator
    }
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Functions
    //----------------------------------------------------------------------------------------------------------------
    func backTOLoginViewController(){
        coordinator?.backToLoginViewController()
    }
    
    
    func emailValid()->Observable<Bool>{

        return emailObservable.map { value in
            return value.count >= 6
        }
    }
    
    func passwordValid()->Observable<Bool> {
        return passwordObservable.map { value in
            return value.count >= 8
        }
    }
    
    func re_passwordValid()->Observable<Bool> {
        return re_passwordObservable.map { value in
            return value.count >= 8
        }
    }
    
    
    func passwordIsEqualRe_passwordValidation()-> Observable<Bool>{
        return Observable.combineLatest(re_passwordValid().startWith(false),passwordObservable.startWith(""), re_passwordObservable.startWith("")).map { (repass_Valid,password , re_password) in
            return password == re_password && repass_Valid
        }
    }
    
    
    func startValidWithRegister()->Observable<Bool>{
        return Observable.combineLatest(emailValid().startWith(false), passwordValid().startWith(false), re_passwordValid().startWith(false), passwordIsEqualRe_passwordValidation().startWith(false)).map { (emailState, passwordState, re_passwordState , passAndRePassState) in
            return emailState && passwordState && re_passwordState && passAndRePassState
        }
    }
    
    
    func creatUser(){
        startHud.accept(true)
        AuthFUser.shared.creatUser(email: emailObservable.value, password: passwordObservable.value) { result, error in
            self.startHud.accept(false)
            if let error = error {
                print(error.localizedDescription)
            }else{
                self.coordinator?.backToLoginViewController()
            }
        }
        
    }
}
