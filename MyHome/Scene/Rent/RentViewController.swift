//
// RentViewController.swift
// MyHome
//
// Created by Tin Blanc on 7/9/18.
// Copyright © 2018 tanth. All rights reserved.
//

import UIKit
import Reusable

final class RentViewController: UIViewController, BindableType {

    var viewModel: RentViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    deinit {
        logDeinit()
    }

    func bindViewModel() {
        let input = RentViewModel.Input()
        let output = viewModel.transform(input)
    }

}

// MARK: - StoryboardSceneBased
extension RentViewController: StoryboardSceneBased {
    // TODO: - Update storyboard
    static var sceneStoryboard = UIStoryboard()
}
