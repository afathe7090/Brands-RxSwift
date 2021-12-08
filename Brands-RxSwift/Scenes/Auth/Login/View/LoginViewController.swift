//
//  LoginViewController.swift
//  Rx-MVVM
//
//  Created by Ahmed Fathy on 02/12/2021.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Variables
    //----------------------------------------------------------------------------------------------------------------
    private var viewModel: LoginViewModel!
    private let bag = DisposeBag()
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Outlet
    //----------------------------------------------------------------------------------------------------------------
    @IBOutlet weak var passwordValidLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backView: UIView!{didSet{backView.layer.cornerRadius = 20}}
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButtonActionPressed: UIButton!{didSet{loginButtonActionPressed.layer.cornerRadius = 8}}
    @IBOutlet weak var registerButtonPressed: UIButton!{didSet{registerButtonPressed.layer.cornerRadius = 15}}
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Initialization
    //----------------------------------------------------------------------------------------------------------------
    init(viewModel: LoginViewModel = LoginViewModel()){
        super.init(nibName: "LoginViewController", bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Life Cycle
    //----------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindingToViewModel()
        bindingForValidPassword()
        binding_To_Enable_Or_Disable_Valid_Email_And_Password()
        tabActionForLoginButtonPressed()
        tabToGoRegisterPageView()
        startBindingToUseProgressHud()
    }
    
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Helper Functions
    //----------------------------------------------------------------------------------------------------------------
    func bindingToViewModel(){
        
        emailTextField.rx.text.orEmpty
            .bind(to: viewModel.emailObservable).disposed(by: bag)
        
        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.passwordObservable).disposed(by: bag)
        
    }
    
    
    
    func bindingForValidPassword(){
        viewModel.passwordValid()
            .subscribe(onNext: {state in
                self.passwordValidLabel.text = state ? "Password Is Valid 😀😀 " : "You must Enter min 8 char "
                self.passwordValidLabel.textColor = state ? .green : .red
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    UIView.animate(withDuration: 0.2) {
                        self.passwordValidLabel.alpha = state ? 0:1
                    }
                }
                
            }).disposed(by: bag)
    }
    
    
    func binding_To_Enable_Or_Disable_Valid_Email_And_Password(){
        viewModel.emailAndPasswordValid()
            .subscribe(onNext: {state in
                self.loginButtonActionPressed.alpha = state ? 1:0.75
                self.loginButtonActionPressed.isEnabled = state
            }).disposed(by: bag)
    }
    
    
    func startBindingToUseProgressHud(){
        viewModel.startHud.subscribe(onNext: {state in
            state ? Hud.showHud(in: self.view): Hud.dismiss()
        }).disposed(by: bag)
    }
    
    
    func tabActionForLoginButtonPressed(){
        loginButtonActionPressed.rx
            .tap.bind { _ in
                self.viewModel.userSignIn()
            }.disposed(by: bag)
    }
    
    
    func tabToGoRegisterPageView(){
        registerButtonPressed.rx.tap.bind { _ in
            self.viewModel.goToRigesterPageView()
        }.disposed(by: bag)
    }
    
}


