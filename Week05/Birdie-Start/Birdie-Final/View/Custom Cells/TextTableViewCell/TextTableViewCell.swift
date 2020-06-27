//
//  TextTableViewCell.swift
//  Birdie-Final
//
//  Created by Sagun Raj Lage on 6/27/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell {

    @IBOutlet weak private var messageLabel: UILabel!
    @IBOutlet weak private var dateTimeLabel: UILabel!
    @IBOutlet weak private var usernameLabel: UILabel!
    @IBOutlet weak private var badgeImageView: UIImageView!
    
    func setupCell(with mediaPost: MediaPost) {
        usernameLabel.text = mediaPost.userName
        dateTimeLabel.text = mediaPost.timestamp.getDateString(ofFormat: "dd MMM, HH:mm")
        messageLabel.text = mediaPost.textBody
    }
    
}
