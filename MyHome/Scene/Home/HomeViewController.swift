//
// HomeViewController.swift
// KnotBuilder
//
// Created by tran.huu.tan on 4/15/18.
// Copyright © 2018 Framgia. All rights reserved.
//

import UIKit
import Reusable

final class HomeViewController: UIViewController, BindableType {

    var viewModel: HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    func bindViewModel() {
        let input = HomeViewModel.Input()
        let output = viewModel.transform(input)
    }
    
    // MARK: - Private Methods
    fileprivate func configUI() {
        title = "tab.home".localized()
    }

}

// MARK: - StoryboardSceneBased
extension HomeViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard = Storyboards.home.instance
}
