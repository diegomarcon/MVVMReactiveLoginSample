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

    let loginButtonEnabled = Property<Bool>(false)

    init(user: Property<String?>, password: Property<String?>) {
        combineLatest(user, password).observeNext {[unowned self] user, password in
            self.loginButtonEnabled.value = LoginValidator.isValid(user, password: password)
        }.disposeIn(disposeBag)
    }
}