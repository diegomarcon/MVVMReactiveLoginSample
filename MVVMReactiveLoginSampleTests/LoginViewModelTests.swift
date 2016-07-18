//
//  LoginViewModelTests.swift
//  LoginViewModelTests
//
//  Created by Diego Marcon on 7/18/16.
//  Copyright © 2016 marcon. All rights reserved.
//

import Quick
import Nimble
import ReactiveKit
@testable import MVVMReactiveLoginSample

class LoginViewModelSpec: QuickSpec {
    var api = LoginMockedApi()
    var taps = PushStream<Void>()
    var user = Property<String?>("")
    var password = Property<String?>("")
    var viewModel: LoginViewModel!

    override func spec() {
        beforeEach() {
            self.viewModel = LoginViewModel(loginTaps: self.taps.toStream(),
                                                 user: self.user,
                                             password: self.password,
                                                  api: self.api)
        }

        describe("the login view model") {

            it("should disable login button if user and password are empty") {
                self.user.value = ""
                self.password.value = ""
                expect(self.viewModel.loginButtonEnabled.value) == false
            }

            it("should disable login button if only user are empty") {
                self.user.value = ""
                self.password.value = "password"
                expect(self.viewModel.loginButtonEnabled.value) == false
            }

            it("should disable login button if only password are empty") {
                self.user.value = "someUser"
                self.password.value = ""
                expect(self.viewModel.loginButtonEnabled.value) == false
            }

            it("should enable login button if user and password aren't empty") {
                self.user.value = "someUser"
                self.password.value = "password"
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
        }
    }

    class LoginMockedApi: LoginApiProtocol {
        let response = PushStream<LoginResponse>()

        func login(user: String, password: String) -> Stream<LoginResponse> {
            return response.toStream()
        }
    }
}