//
//  ImageTableViewCell.swift
//  Birdie-Final
//
//  Created by Sagun Raj Lage on 6/27/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var messageLabel: UILabel!
    @IBOutlet weak private var dateTimeLabel: UILabel!
    @IBOutlet weak private var usernameLabel: UILabel!
    @IBOutlet weak private var badgeImageView: UIImageView!
    @IBOutlet weak private var messageImageView: UIImageView!
    
    func setupCell(with imagePost: ImagePost) {
        usernameLabel.text = imagePost.userName
        dateTimeLabel.text = imagePost.timestamp.getDateString(ofFormat: "dd MMM, HH:mm")
        messageLabel.text = imagePost.textBody
        messageImageView.image = imagePost.image
    }
    
}
