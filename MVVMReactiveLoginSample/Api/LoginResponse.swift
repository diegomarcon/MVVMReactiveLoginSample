//
//  LoginResponse.swift
//  MVVMReactiveLoginSample
//
//  Created by Diego Marcon on 7/18/16.
//  Copyright © 2016 marcon. All rights reserved.
//

enum LoginResponse {
    case Success(token: String)
    case Failure(message: String?)
}