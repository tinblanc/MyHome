//
//  BaseNavigatorController.swift
//  MyHome
//
//  Created by Tin Blanc on 7/6/18.
//  Copyright © 2018 Tin Blanc. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.do {
            $0.tintColor = UIColor.white
            $0.barTintColor = UIColor.blueA
            $0.titleTextAttributes = [
                NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 17),
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
}
