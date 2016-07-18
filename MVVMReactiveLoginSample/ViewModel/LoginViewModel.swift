//
//  LoginViewModel.swift
//  MVVMReactiveLoginSample
//
//  Created by Diego Marcon on 7/18/16.
//  Copyright © 2016 marcon. All rights reserved.
//

import ReactiveKit

class LoginViewModel {
    private let disposeBag = DisposeBag()

    let signingIn = Property<Bool>(false)
    let loginButtonEnabled = Property<Bool>(false)
    let error = Property<String?>(nil)
    let authToken = Property<String?>(nil)
    var taps = Property<Void>()

    init(loginTaps: Stream<Void>, user: Property<String?>,
         password: Property<String?>, api: LoginApiProtocol = LoginApi()) {

        loginTaps.observeNext({[unowned self] in
            self.login(user.value, password: password.value, api: api)
        }).disposeIn(disposeBag)

        combineLatest(user, password).observeNext {[unowned self] user, password in
            self.loginButtonEnabled.value = LoginValidator.isValid(user, password: password)
        }.disposeIn(disposeBag)
    }

    private func login(user: String?, password: String?, api: LoginApiProtocol) {
        signingIn.value = true

        api.login(user!, password: password!).observeNext({ [weak self] response in
            self?.signingIn.value = false

            switch response {
            case .Failure(let message):
                self?.error.value = message
            case .Success(let token):
                self?.authToken.value = token
            }
        }).disposeIn(disposeBag)
    }
}