//
//  MessagePresenter.swift
//  MVVMReactiveLoginSample
//
//  Created by Diego Marcon on 7/18/16.
//  Copyright © 2016 marcon. All rights reserved.
//

import UIKit

protocol MessagePresenter {
    func showErrorMessage(error: String?)
    func showMessage(message: String?, title: String?)
}

extension MessagePresenter where Self: UIViewController {
    func showErrorMessage(error: String?) {
        showMessage(message: error, title: "Something went wrong")
    }

    func showMessage(message: String?, title: String? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
