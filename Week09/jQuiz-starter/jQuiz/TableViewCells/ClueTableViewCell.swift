//
//  ClueTableViewCell.swift
//  jQuiz
//
//  Created by Sagun Raj Lage on 7/27/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ClueTableViewCell: UITableViewCell {

    static let reuseIdentifier = "ClueTableViewCell"

    @IBOutlet weak private var clueTitle: UILabel!
    
    override func awakeFromNib() {
        clueTitle.font = Fonts.Regular.r2
    }

    func setupClueTitle(with title: String) {
        clueTitle.text = title
    }

}
