//
// RoomCell.swift
// MyHome
//
// Created by Tin Blanc on 7/6/18.
// Copyright © 2018 tanth. All rights reserved.
//

import UIKit

final class RoomCell: UICollectionViewCell, NibReusable {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var containerView: ShadowView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.do {
            $0.layer.cornerRadius = 5
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor(white: 205).cgColor
            $0.shadowRadius = 3
            $0.shadowOffsetWidth = 2
            $0.shadowOffsetHeight = 2
        }
        
        nameLabel.do {
            $0.textColor = UIColor.white
            $0.font = UIFont.boldSystemFont(ofSize: 15)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        configView(with: nil)
    }

    func configView(with model: RoomsViewModel.RoomModel?) {
        if let model = model {
            nameLabel.text = model.room.name
            nameLabel.textColor = model.room.userId.isEmpty
                ? UIColor.darkGray.withAlphaComponent(0.7)
                : UIColor.white
            
            containerView.backgroundColor = model.room.userId.isEmpty
                ? UIColor.white
                : UIColor.blueA
        } else {
            nameLabel.text = ""
        }
    }
}

