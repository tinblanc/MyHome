//
//  UITableView+.swift
//  Knot
//
//  Created by tran.huu.tan on 3/16/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import UIKit

extension UIScrollView {
    func fixContentInset(_ contentInset: CGFloat = -45) {
        if #available(iOS 11, *) {
            
        } else {
            self.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: contentInset, right: 0)
            self.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: contentInset, right: 0)
        }
    }
}

extension UITableView {
    func fixFooterFrame() {
        if let footerView = self.tableFooterView {
            let height: CGFloat = 30
            var footerFrame = footerView.frame
            if height != footerFrame.size.height {
                footerFrame.size.height = height
                footerView.frame = footerFrame
            }
        }
    }
}
