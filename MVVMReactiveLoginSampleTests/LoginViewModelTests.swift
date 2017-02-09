//
//  LoginViewModelTests.swift
//  LoginViewModelTests
//
//  Created by Diego Marcon on 7/18/16.
//  Copyright © 2016 marcon. All rights reserved.
//

import Quick
import Nimble
import Bond
import ReactiveKit
@testable import MVVMReactiveLoginSample

class LoginViewModelSpec: QuickSpec {
    var api = LoginMockedApi()
    var taps = SafePublishSubject<Void>()
    var user = SafePublishSubject<String?>()
    var password = SafePublishSubject<String?>()
    var viewModel: LoginViewModel!

    override func spec() {
        beforeEach() {
            self.viewModel = LoginViewModel(loginTaps: self.taps.toSignal(),
                                                 user: self.user.toSignal(),
                                             password: self.password.toSignal(),
                                                  api: self.api)
        }

        describe("the login view model") {

            it("should disable login button if user and password are empty") {
                self.user.next("")
                self.password.next("")
                expect(self.viewModel.loginButtonEnabled.value) == false
            }

            it("should disable login button if only user are empty") {
                self.user.next("")
                self.password.next("password")
                expect(self.viewModel.loginButtonEnabled.value) == false
            }

            it("should disable login button if only password are empty") {
                self.user.next("someUser")
                self.password.next("")
                expect(self.viewModel.loginButtonEnabled.value) == false
            }

            it("should enable login button if user and password aren't empty") {
                self.user.next("someUser")
                self.password.next("password")
                expect(self.viewModel.loginButtonEnabled.value) == true
            }

            it("should update token if login is sucessfull") {
                let token = "token"
                self.taps.next()
                self.api.response.next(LoginResponse.Success(token: token))
                expect(self.viewModel.authToken.value) == token
            }

            it("should update error message if login fails") {
                let error = "error"
                self.taps.next()
                self.api.response.next(LoginResponse.Failure(message: error))
                expect(self.viewModel.error.value) == error
            }

            it("should update signing in status while logging in") {
                expect(self.viewModel.signingIn.value) == false
                self.taps.next()
                expect(self.viewModel.signingIn.value) == true
                self.api.response.next(LoginResponse.Success(token: ""))
                expect(self.viewModel.signingIn.value) == false
            }
        }
    }

    class LoginMockedApi: LoginApiProtocol {
        let response = SafePublishSubject<LoginResponse>()

        func login(user: String, password: String) -> SafeSignal<LoginResponse> {
            return response.toSignal()
        }
    }
}
