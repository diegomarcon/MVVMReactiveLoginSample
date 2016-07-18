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
        showMessage(error, title: "Something went wrong")
    }

    func showMessage(message: String?, title: String? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .Alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}