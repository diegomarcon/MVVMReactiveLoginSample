//
//  LoginViewController.swift
//  MVVMReactiveLoginSample
//
//  Created by Diego Marcon on 7/18/16.
//  Copyright © 2016 marcon. All rights reserved.
//

import ReactiveUIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UIButton!

    private var viewModel: LoginViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel(user: username.rText, password: password.rText)
        bindEvents()
    }

    private func bindEvents() {
        viewModel?.loginButtonEnabled.bindTo(login.rEnabled)
    }
}