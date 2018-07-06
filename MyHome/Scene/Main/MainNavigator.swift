//
//  MainNavigator.swift
//  MyHome
//
//  Created by Tin Blanc on 4/15/18.
//  Copyright © 2018 Tin Blanc. All rights reserved.
//

import UIKit

enum TabBarItemType: Int {
    case top
    case conversation
    case calendar
    case todo
    case profile
    case notification
}

protocol MainNavigatorType {
    func toMain()
}

struct MainNavigator: MainNavigatorType {
    
    let window: UIWindow
    
    func toMain() {
        let roomsNav = BaseNavigationController().then {
            $0.tabBarItem = UITabBarItem(title: "tab.home".localized(),
                                         image: #imageLiteral(resourceName: "tabbar_icon_home_off"),
                                         selectedImage: #imageLiteral(resourceName: "tabbar_icon_home_on"))
                .then {
                    $0.tag = TabBarItemType.top.rawValue
            }
        }
        
        let mainTabBarController = MainTabBarController().then {
            $0.viewControllers = [
                roomsNav
            ]
        }
        window.rootViewController = mainTabBarController
        window.makeKeyAndVisible()
        
        let roomsNavigator = RoomsNavigator( navigationController: roomsNav)
        roomsNavigator.toRooms()
    }
}
