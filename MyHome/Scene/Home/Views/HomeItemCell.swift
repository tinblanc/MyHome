//
//  HomeItemCell.swift
//  MyHome
//
//  Created by Tin Blanc on 4/26/18.
//  Copyright © 2018 Tin Blanc. All rights reserved.
//

import UIKit

class HomeItemCell: UITableViewCell, NibReusable {
    
    // MARK: - Outlets
    @IBOutlet weak var roomNameLabel: UILabel! {
        didSet {
            roomNameLabel?.do {
                $0.font = UIFont.boldSystemFont(ofSize: 19.0)
                $0.textColor = UIColor.baseTextColor
            }
        }
    }
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel?.do {
                $0.font = UIFont.systemFont(ofSize: 15.0)
                $0.textColor = UIColor.warmGrey
            }
        }
    }
    @IBOutlet weak var priceButton: UIButton! {
        didSet {
            priceButton?.do {
                $0.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
                $0.tintColor = UIColor(red: 241, green: 141, blue: 138, alpha: 1.0)
            }
        }
    }
    
    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var isPaidImageView: UIImageView! {
        didSet {
            isPaidImageView?.do {
                $0.layer.borderWidth = 2.0
                $0.layer.borderColor = UIColor.baseTextColor.withAlphaComponent(0.5).cgColor
                $0.layer.cornerRadius = $0.bounds.size.height / 2
            }
        }
    }
    
    // MARK: - Properties
    var room: Room? {
        didSet {
            guard let room = room else { return }
            configData(room: room)
        }
    }

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    fileprivate func configView() {
        view?.do {
            $0.layer.shadowColor = UIColor.baseTextColor.cgColor
            $0.layer.shadowRadius = 6.0
            $0.layer.shadowOpacity = 0.5
            
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor.baseTextColor.withAlphaComponent(0.5).cgColor
            $0.layer.cornerRadius = 6.0
        }
    }
    
    fileprivate func configData(room: Room) {
        roomNameLabel.text = String(format: "%d", room.id)
    }
    
}
