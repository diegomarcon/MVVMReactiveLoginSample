//
//  LoginViewModel.swift
//  MVVMReactiveLoginSample
//
//  Created by Diego Marcon on 7/18/16.
//  Copyright © 2016 marcon. All rights reserved.
//

import ReactiveKit
import Bond

class LoginViewModel {
    private let disposeBag = DisposeBag()
    private var currentUser = ""
    private var currentPassword = ""

    let signingIn = Property<Bool>(false)
    let loginButtonEnabled = Property<Bool>(false)
    let error = Property<String?>(nil)
    let authToken = Property<String?>(nil)

    init(loginTaps: SafeSignal<Void>, user: SafeSignal<String?>,
         password: SafeSignal<String?>, api: LoginApiProtocol = LoginApi()) {

        loginTaps.observeNext(with: {[unowned self] in
            self.login(api: api)
        }).dispose(in: disposeBag)

        combineLatest(user, password).observeNext {[unowned self] user, password in
            if let user = user, let password = password {
                self.currentUser = user
                self.currentPassword = password
            }

            self.loginButtonEnabled.value = LoginValidator.isValid(user: user, password: password)
        }.dispose(in: disposeBag)
    }

    private func login(api: LoginApiProtocol) {
        signingIn.value = true

        api.login(user: currentUser, password: currentPassword).observeNext(with: { [weak self] response in
            self?.signingIn.value = false

            switch response {
            case .Failure(let message):
                self?.error.value = message
            case .Success(let token):
                self?.authToken.value = token
            }
        }).dispose(in: disposeBag)
    }
}
