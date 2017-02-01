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

    let signingIn = Property<Bool>(false)
    let loginButtonEnabled = Property<Bool>(false)
    let error = Property<String?>(nil)
    let authToken = Property<String?>(nil)

    init(loginTaps: SafeSignal<Void>, user: DynamicSubject<String?>,
         password: DynamicSubject<String?>, api: LoginApiProtocol = LoginApi()) {

        loginTaps.observeNext(with: {[unowned self] in
            self.login(user: user.value, password: password.value, api: api)
        }).dispose(in: disposeBag)

        combineLatest(user, password).observeNext {[unowned self] user, password in
            self.loginButtonEnabled.value = LoginValidator.isValid(user: user, password: password)
        }.dispose(in: disposeBag)
    }

    private func login(user: String?, password: String?, api: LoginApiProtocol) {
        signingIn.value = true

        api.login(user: user!, password: password!).observeNext(with: { [weak self] response in
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
