//
//  LoginApi.swift
//  MVVMReactiveLoginSample
//
//  Created by Diego Marcon on 7/18/16.
//  Copyright © 2016 marcon. All rights reserved.
//

import Alamofire
import ReactiveAlamofire
import ReactiveKit

class LoginApi: LoginApiProtocol {
    private let url = "your.url.here"

    func login(user: String, password: String) -> Stream<LoginResponse> {
        let parameters = ["user" : user, "password" : password]

        return Alamofire.request(.GET, url, parameters: parameters)
            .toJSONOperation()
            .flatMapError { error in
                return Stream.just(["error" : error.localizedDescription])
            }.map({[unowned self] json in
                return self.parseResponse(json)
            })
    }

    private func parseResponse(json: AnyObject?) -> LoginResponse {
        if let json = json as? Dictionary<String, AnyObject> {
            if let error = json["error"] as? String {
                return .Failure(message: error)
            } else if let token = json["token"] as? String {
                return .Success(token: token)
            }
        }

        return .Failure(message: "Unexpected response")
    }
}