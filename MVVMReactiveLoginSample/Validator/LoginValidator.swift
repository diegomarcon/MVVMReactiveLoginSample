//
//  LoginValidator.swift
//  MVVMReactiveLoginSample
//
//  Created by Diego Marcon on 7/18/16.
//  Copyright © 2016 marcon. All rights reserved.
//

class LoginValidator {
    class func isValid(user: String?, password: String?) -> Bool {
        guard let user = user, let password = password else {
            return false
        }

        return !user.isEmpty && !password.isEmpty
    }
}