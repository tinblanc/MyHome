//
// RoomCell.swift
// MyHome
//
// Created by Tin Blanc on 7/6/18.
// Copyright © 2018 tanth. All rights reserved.
//

import UIKit

final class RoomCell: UITableViewCell, NibReusable {
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var contractIdLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var oldElectricityUsedLabel: UILabel!
    @IBOutlet weak var newElectricityUsedLabel: UILabel!
    @IBOutlet weak var isUseInternetLabel: UILabel!
    @IBOutlet weak var isUseCleaningLabel: UILabel!
    @IBOutlet weak var numberPeopleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateOfPaymentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        configView(with: nil)
    }

    func configView(with model: RoomsViewModel.RoomModel?) {
        if let model = model {

        } else {
            userIdLabel.text = ""
            contractIdLabel.text = ""
            nameLabel.text = ""
            oldElectricityUsedLabel.text = ""
            newElectricityUsedLabel.text = ""
            isUseInternetLabel.text = ""
            isUseCleaningLabel.text = ""
            numberPeopleLabel.text = ""
            priceLabel.text = ""
            dateOfPaymentLabel.text = ""
        }
    }
}

