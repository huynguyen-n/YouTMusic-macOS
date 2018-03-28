//
//  LoginViewController.swift
//  YouTMusic
//
//  Created by Huy Nguyễn on 2/12/18.
//  Copyright © 2018 Huy Nguyen. All rights reserved.
//

import Cocoa
import RxCocoa
import YouTMusicCore

class LoginViewController: BaseViewController {
    
    // MARK: - Variable
    fileprivate var viewModel: AuthenticateViewModelProtocol!
    @IBOutlet weak var btnLogin: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnLogin.rx.tap.bind(to: viewModel.input.loginBtnOnTapPublish).disposed(by: disposeBag)
    }
    
    public class func buildController(_ coordinator: ViewModelCoordinatorProtocol) -> LoginViewController {
        let login = LoginViewController(nibName: NSNib.Name(rawValue: "LoginViewController"), bundle: nil)
        login.viewModel = coordinator.authenViewModel
        return login
    }
}
