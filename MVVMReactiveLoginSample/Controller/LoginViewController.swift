//
//  LoginViewController.swift
//  MVVMReactiveLoginSample
//
//  Created by Diego Marcon on 7/18/16.
//  Copyright © 2016 marcon. All rights reserved.
//

import ReactiveUIKit

class LoginViewController: UIViewController, LoadingView, MessagePresenter {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UIButton!

    private var viewModel: LoginViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel(loginTaps: login.rTap,
                                        user: username.rText,
                                    password: password.rText)
        bindEvents()
    }

    private func bindEvents() {
        viewModel?.loginButtonEnabled.bindTo(login.rEnabled)

        viewModel?.signingIn.observeNext({[weak self] signingIn in
            signingIn ? self?.showLoadingView() : self?.hideLoadingView()
        }).disposeIn(rBag)

        viewModel?.authToken.observeNext({[weak self] token in
            if let token = token {
                print("Hey, logged in with token \(token)")
                self?.showMessage("Logged in!", title: "Success")
            }
        }).disposeIn(rBag)

        viewModel?.error.observeNext({[weak self] error in
            if let error = error {
                print("Error: \(error)")
                self?.showErrorMessage(error)
            }
        }).disposeIn(rBag)
    }
}