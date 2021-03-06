//
//  LoginViewController.swift
//  MVVMReactiveLoginSample
//
//  Created by Diego Marcon on 7/18/16.
//  Copyright © 2016 marcon. All rights reserved.
//

import ReactiveKit
import Bond

class LoginViewController: UIViewController, LoadingView, MessagePresenter {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UIButton!

    private let disposeBag = DisposeBag()
    private var viewModel: LoginViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel(loginTaps: login.reactive.tap,
                                        user: username.reactive.text.toSignal(),
                                    password: password.reactive.text.toSignal())
        bindEvents()
    }

    private func bindEvents() {
        viewModel?.loginButtonEnabled.bind(to: login.reactive.isEnabled)

        viewModel?.signingIn.observeNext(with: {[weak self] signingIn in
            signingIn ? self?.showLoadingView() : self?.hideLoadingView()
        }).dispose(in: disposeBag)

        viewModel?.authToken.observeNext(with: {[weak self] token in
            if let token = token {
                print("Hey, logged in with token \(token)")
                self?.showMessage(message: "Logged in!", title: "Success")
            }
        }).dispose(in: disposeBag)

        viewModel?.error.observeNext(with: {[weak self] error in
            if let error = error {
                print("Error: \(error)")
                self?.showErrorMessage(error: error)
            }
        }).dispose(in: disposeBag)
    }
}
