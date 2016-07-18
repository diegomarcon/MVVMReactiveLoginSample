//
//  LoginApiProtocol.swift
//  MVVMReactiveLoginSample
//
//  Created by Diego Marcon on 7/18/16.
//  Copyright © 2016 marcon. All rights reserved.
//

import ReactiveKit

protocol LoginApiProtocol {
    func login(user: String, password: String) -> Stream<LoginResponse>
}