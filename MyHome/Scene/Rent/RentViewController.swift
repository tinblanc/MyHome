//
// RentViewController.swift
// MyHome
//
// Created by Tin Blanc on 7/9/18.
// Copyright © 2018 tanth. All rights reserved.
//

import UIKit
import Reusable

final class RentViewController: UITableViewController, BindableType {
    @IBOutlet weak var roomNameTextField: ValidationTextField!
    @IBOutlet weak var priceTextField: ValidationTextField!
    @IBOutlet weak var oldElectricityTextField: ValidationTextField!
    @IBOutlet weak var numberPeoplesTextField: ValidationTextField!
    
    @IBOutlet weak var userNameTextField: ValidationTextField!
    @IBOutlet weak var phoneNumberTextField: ValidationTextField!
    @IBOutlet weak var depositsTextField: ValidationTextField!
    @IBOutlet weak var noteTextField: ValidationTextField!
    @IBOutlet weak var startDateTextField: ValidationTextField!
    
    @IBOutlet weak var internetLabel: UILabel!
    @IBOutlet weak var internetCheckBox: BEMCheckBox!

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var closeButton: UIBarButtonItem!
    
    // MARK: Subject Properties
    fileprivate let internetCheckBoxTrigger = PublishSubject<Bool>()

    var viewModel: RentViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    fileprivate func configView() {
        navigationItem.title = "rent.room.navigation.title".localized()
        
        // Button
        addButton.do {
            $0.layer.cornerRadius = 6.0
            $0.setTitle("rent.room.button.rent.title".localized(), for: .normal)
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
            $0.backgroundColor = UIColor.blueA
        }
        
        // Label
        internetLabel.do {
            $0.text = "rent.room.label.internet.title".localized()
            $0.textColor = UIColor.lightGray
            $0.font = UIFont.systemFont(ofSize: 15.0)
        }
        
        // Checkbox
        internetCheckBox.do {
            $0.boxType = .square
            $0.onAnimationType = .bounce
            $0.offAnimationType = .bounce
            
            $0.onFillColor = UIColor.blueA
            $0.onTintColor = UIColor.blueA
            $0.onCheckColor = UIColor.white
            
            $0.tintColor = UIColor.blueA
        }
        
        // TextField
        roomNameTextField.do {
            $0.placeholder = "rent.room.label.name.title".localized()
            $0.setup()
            $0.disabledColor = UIColor.blueA
            $0.isEnabled = false
            
            // TODO: Mock
            $0.text = "Phòng 303"
            
        }
        priceTextField.do {
            $0.placeholder = "rent.room.label.price.title".localized()
            $0.setup()
        }
        oldElectricityTextField.do {
            $0.placeholder = "rent.room.label.old.electric.title".localized()
            $0.setup()
        }
        numberPeoplesTextField.do {
            $0.placeholder = "rent.room.label.number.peoples.title".localized()
            $0.setup()
        }
        
        userNameTextField.do {
            $0.placeholder = "rent.room.label.user.name.title".localized()
            $0.setup()
        }
        phoneNumberTextField.do {
            $0.placeholder = "rent.room.label.phone.number.title".localized()
            $0.setup()
        }
        depositsTextField.do {
            $0.placeholder = "rent.room.label.deposits.title".localized()
            $0.setup()
        }
        noteTextField.do {
            $0.placeholder = "rent.room.label.note.title".localized()
            $0.setup()
        }
        startDateTextField.do {
            $0.placeholder = "rent.room.label.start.date.title".localized()
            $0.setup()
        }
        
    }

    deinit {
        logDeinit()
    }

    // MARK: - bindViewModel
    func bindViewModel() {
        
        let input = RentViewModel.Input(
            addTrigger: addButton.rx.tap.asDriver(),
            closeTrigger: closeButton.rx.tap.asDriver(),
            price: priceTextField.rx.text.orEmpty.asDriver(),
            oldElectricity: oldElectricityTextField.rx.text.orEmpty.asDriver(),
            numberPeoples: numberPeoplesTextField.rx.text.orEmpty.asDriver(),
            userName: userNameTextField.rx.text.orEmpty.asDriver(),
            phoneNumber: phoneNumberTextField.rx.text.orEmpty.asDriver(),
            deposits: depositsTextField.rx.text.orEmpty.asDriver(),
            note: noteTextField.rx.text.orEmpty.asDriver(),
            startDate: startDateTextField.rx.text.orEmpty.asDriver(),
            internet: internetCheckBoxTrigger.asDriverOnErrorJustComplete())
        
        let output = viewModel.transform(input)
        
        output.added
            .drive()
            .disposed(by: rx.disposeBag)
        output.close
            .drive()
            .disposed(by: rx.disposeBag)
    }

    // MARK: - IBActions
    @IBAction func startDateTextFieldEditing(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self,
                                 action: #selector(self.datePickerValueChanged),
                                 for: UIControlEvents.valueChanged)
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        startDateTextField.text = sender.date.toDate()
    }
}

// MARK: - StoryboardSceneBased
extension RentViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.home.instance
}

// MARK: BEMCheckBoxDelegate
extension RentViewController: BEMCheckBoxDelegate {
    func didTap(_ checkBox: BEMCheckBox) {
        print(checkBox.on)
        internetCheckBoxTrigger.onNext(checkBox.on)
    }
}
