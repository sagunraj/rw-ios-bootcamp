//
//  NotificationView.swift
//  FlappyBird
//
//  Created by Sagun Raj Lage on 8/10/20.
//  Copyright © 2020 Sagun Raj Lage. All rights reserved.
//

import UIKit

enum NotificationType: String {
    case add = "Animation added successfully!"
    case remove = "Animation removed successfully!"
}

final class NotificationView: UIView {
    
    let nibName = "NotificationView"
    var contentView: UIView?
    
    @IBOutlet weak private var wrapperView: UIView!
    @IBOutlet weak private var iconImageView: UIImageView!
    @IBOutlet weak private var notificationTextLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        guard let view = loadViewFromNib(with: nibName) else { return }
        view.frame = self.bounds
        self.addSubview(view)
        setupView()
        contentView = view
    }
    
    private func setupView() {
        wrapperView.layer.cornerRadius = 10.0
    }
    
    func displayNotification(with notificationType: NotificationType) {
        notificationTextLabel.text = notificationType.rawValue
        switch notificationType {
        case .add:
            iconImageView.image = #imageLiteral(resourceName: "checkmark")
        case .remove:
            iconImageView.image = #imageLiteral(resourceName: "crossmark")
        }
    }
    
}
