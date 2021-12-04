//
//  RegisterViewController.swift
//  Rx-MVVM
//
//  Created by Ahmed Fathy on 02/12/2021.
//

import UIKit
import RxCocoa
import RxSwift

class RegisterViewController: UIViewController {

    private var viewModel: RegisterViewModel!
    private let bag = DisposeBag()
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Outlet
    //----------------------------------------------------------------------------------------------------------------
    @IBOutlet weak var backView: UIView!{didSet{backView.layer.cornerRadius = 20}}
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repasswordTextField: UITextField!
    @IBOutlet weak var registerButtonPressed: UIButton!{didSet{registerButtonPressed.layer.cornerRadius = 8}}
    @IBOutlet weak var loginButtonPressed: UIButton!{didSet{loginButtonPressed.layer.cornerRadius = 15}}
    @IBOutlet weak var repasswordValidlabel: UILabel!
    @IBOutlet weak var passwordValidLabel: UILabel!
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Init
    //----------------------------------------------------------------------------------------------------------------
    init(viewModel: RegisterViewModel){
        super.init(nibName: "RegisterViewController", bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    

    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Life Cycle
    //----------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setActionTapForLoginButtonPressed()
        bindingToViewModel()
        startBindingFromViewModelToPasswordTextField()
        startBindingFromViewModelToRePassordTextField()
        startBindingToUseProgressHud()
        startBindingFromViewModelToRegisterButton()
        startActionToRegisterButtonPressed()
    }

    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Helper Functions
    //----------------------------------------------------------------------------------------------------------------
    func setActionTapForLoginButtonPressed(){
        loginButtonPressed.rx.tap.bind { _ in
            self.viewModel.backTOLoginViewController()
        }.disposed(by: bag)
    }
    
    
        
    func bindingToViewModel(){
        emailTextField.rx.text.orEmpty
            .bind(to: viewModel.emailObservable).disposed(by: bag)
        
        passwordTextField.rx.text
            .orEmpty.bind(to: viewModel.passwordObservable).disposed(by: bag)
        
        repasswordTextField.rx.text
            .orEmpty.bind(to: viewModel.re_passwordObservable).disposed(by: bag)
    }
    
    
 
    
        
    func startBindingFromViewModelToPasswordTextField(){
        viewModel.passwordValid().bind { state in
            self.passwordValidLabel.textColor = state ? .green:.red
            self.passwordValidLabel.text = state ? "Password Is Valid 😀😀 " : "You must Enter min 8 char "
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                UIView.animate(withDuration: 0.2) {
                    self.passwordValidLabel.alpha = state ? 0:1
                }
            }
            
        }.disposed(by: bag)
    }
    
    
    
    func startBindingFromViewModelToRePassordTextField(){
        viewModel.passwordIsEqualRe_passwordValidation().bind { state in
            
            self.repasswordValidlabel.textColor = state ? .green:.red
            self.repasswordValidlabel.text = state ? "Password Is Valid 😀😀 " : "You must Enter min 8 char "
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                UIView.animate(withDuration: 0.2) {
                    self.repasswordValidlabel.alpha = state ? 0:1
                }
            }
            
        }.disposed(by: bag)
    }
    
    
    
    
    func startBindingFromViewModelToRegisterButton(){
        viewModel.startValidWithRegister().bind { state in
            self.registerButtonPressed.alpha = state ? 1:0.7
            self.registerButtonPressed.isEnabled = state
        }.disposed(by: bag)
    }
    
    
    
    
    func startBindingToUseProgressHud(){
        viewModel.startHud.subscribe(onNext: {state in
            state ? Hud.showHud(in: self.view): Hud.dismiss()
        }).disposed(by: bag)
    }
    
    
    
    func startActionToRegisterButtonPressed(){
        registerButtonPressed.rx.tap.bind { _ in
            self.viewModel.creatUser()
        }.disposed(by: bag)
    }

}
