//
//  BaseNavigationController.swift
//  Knot
//
//  Created by Tuan Truong on 1/25/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.do {
            $0.tintColor = UIColor.white
            $0.barTintColor = UIColor.globalTint
            $0.titleTextAttributes = [
                NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15),
                NSAttributedStringKey.foregroundColor: UIColor.white
            ]
            $0.isTranslucent = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: true)
        viewController.removeBackButtonTitle()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
