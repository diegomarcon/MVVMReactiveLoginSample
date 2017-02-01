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

    func login(user: String, password: String) -> SafeSignal<LoginResponse> {
        let parameters = ["user" : user, "password" : password]

        return Alamofire.request(url, method: .get, parameters: parameters)
            .toJSONSignal()
            .flatMapError { error in
                return SafeSignal.just(["error" : error.localizedDescription])
            }.map { [unowned self] json in
                return self.parseResponse(json: json)
            }
    }

    private func parseResponse(json: Any?) -> LoginResponse {
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
