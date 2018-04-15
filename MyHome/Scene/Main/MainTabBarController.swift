//
//  MainTabBarController.swift
//  MyHome
//
//  Created by Tin Blanc on 4/15/18.
//  Copyright © 2018 Tin Blanc. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let tabBarItemType = TabBarItemType(rawValue: item.tag) else { return }
        NotificationCenter.default.post(name: Notification.Name.changeTab,
                                        object: tabBarItemType)
    }
    
}
