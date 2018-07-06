//
//  Utilities.swift
//  MyHome
//
//  Created by Tin Blanc on 7/6/18.
//  Copyright © 2018 Tin Blanc. All rights reserved.
//

func after(interval: TimeInterval, completion: (() -> Void)?) {
    DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
        completion?()
    }
}

func isIPad() -> Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
}

func appVersion() -> String {
    if let info = Bundle.main.infoDictionary,
        let sortVersion = info["CFBundleShortVersionString"] as? String {
        return sortVersion
    }
    return ""
}

func appVersionWithBuildNumber() -> String {
    if let info = Bundle.main.infoDictionary,
        let sortVersion = info["CFBundleShortVersionString"] as? String,
        let buildNumber = (info["CFBundleVersion"] as? String) {
        return "\(sortVersion) (\(buildNumber))"
    }
    return ""
}

func isEmptyOrNilString(string: String?) -> Bool {
    if let string = string, !string.isEmpty {
        return false
    }
    return true
}

func getTopSafeAreaPadding() -> CGFloat {
    if #available(iOS 11.0, *) {
        let window = UIApplication.shared.keyWindow
        return window?.safeAreaInsets.top ?? 0.0
    } else {
        return 0.0
    }
}

func getBottomSafeAreaPadding() -> CGFloat {
    if #available(iOS 11.0, *) {
        let window = UIApplication.shared.keyWindow
        return window?.safeAreaInsets.bottom ?? 0.0
    } else {
        return 0.0
    }
}
