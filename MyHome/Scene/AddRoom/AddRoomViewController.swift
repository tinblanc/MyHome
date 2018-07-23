//
// AddRoomViewController.swift
// MyHome
//
// Created by Tin Blanc on 7/9/18.
// Copyright © 2018 tanth. All rights reserved.
//

import UIKit
import Reusable

final class AddRoomViewController: UITableViewController, BindableType {
    
    @IBOutlet weak var roomNameTextField: ValidationTextField!
    @IBOutlet weak var priceTextField: ValidationTextField!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var closeButton: UIBarButtonItem!

    var viewModel: AddRoomViewModel!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    fileprivate func configView() {
        navigationItem.title = "add.room.navigation.title".localized()
        
        // Button
        addButton.do {
            $0.layer.cornerRadius = 6.0
            $0.setTitle("common.add".localized(), for: .normal)
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
            $0.backgroundColor = UIColor.blueA
        }
        
        // TextField
        roomNameTextField.do {
            $0.placeholder = "add.room.label.name.title".localized()
            $0.setup()
        }
        priceTextField.do {
            $0.placeholder = "add.room.label.price.title".localized()
            $0.setup()
        }
    }

    deinit {
        logDeinit()
    }

    // MARK: - BindViewModel
    func bindViewModel() {
        let input = AddRoomViewModel.Input(
            name: roomNameTextField.rx.text.orEmpty.asDriverOnErrorJustComplete(),
            price: priceTextField.rx.text.orEmpty.asDriverOnErrorJustComplete(),
            addTrigger: addButton.rx.tap.asDriver(),
            closeTrigger: closeButton.rx.tap.asDriver()
        )
        let output = viewModel.transform(input)

        output.added
            .drive()
            .disposed(by: rx.disposeBag)
        output.close
            .drive()
            .disposed(by: rx.disposeBag)
        output.loading
            .drive(rx.isLoading)
            .disposed(by: rx.disposeBag)
        output.error
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
        
        // Validate
        output.nameValidate
            .drive(roomNameTextField.validationResult)
            .disposed(by: rx.disposeBag)
        output.priceValidate
            .drive(priceTextField.validationResult)
            .disposed(by: rx.disposeBag)
        output.addEnable
            .drive(self.addButton.rx.isEnabled)
            .disposed(by: rx.disposeBag)
        output.addEnable
            .map { $0 ? 1.0 : 0.5 }
            .drive(self.addButton.rx.alpha)
            .disposed(by: rx.disposeBag)
    }

}

// MARK: - StoryboardSceneBased
extension AddRoomViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.home.instance
}
