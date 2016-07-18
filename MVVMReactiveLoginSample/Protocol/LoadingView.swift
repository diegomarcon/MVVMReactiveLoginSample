//
//  LoadingView.swift
//  MVVMReactiveLoginSample
//
//  Created by Diego Marcon on 7/18/16.
//  Copyright © 2016 marcon. All rights reserved.
//

import UIKit

protocol LoadingView {
    func showLoadingView()
    func hideLoadingView()
}

extension LoadingView where Self: UIViewController {
    private var tag: Int {
        return 684
    }
    
    func hideLoadingView() {
        view.viewWithTag(tag)?.removeFromSuperview()
    }
    
    func showLoadingView() {
        let loadingView = UIView(frame: self.view.frame)
        loadingView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        loadingView.addSubview(indicatorView())
        loadingView.tag = tag
        view.addSubview(loadingView)
    }
    
    func indicatorView() -> UIActivityIndicatorView {
        let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
        indicatorView.center = CGPointMake(view.center.x, view.center.y);
        indicatorView.startAnimating()
        return indicatorView
    }
}