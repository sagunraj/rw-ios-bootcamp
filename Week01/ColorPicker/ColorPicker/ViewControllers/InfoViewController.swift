//
//  InfoViewController.swift
//  ColorPicker
//
//  Created by Sagun Raj Lage on 5/30/20.
//  Copyright © 2020 Sagun Raj Lage. All rights reserved.
//

import UIKit
import WebKit

final class InfoViewController: UIViewController {

    @IBOutlet weak private var webView: WKWebView!
    @IBOutlet weak private var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        closeButton.setTitle("", for: .normal)
        closeButton.setImage(#imageLiteral(resourceName: "close.pdf"), for: .normal)
        closeButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        closeButton.tintColor = .black
        guard let url = URL(string: "https://en.wikipedia.org/wiki/RGB_color_model") else { return }
        webView.load(URLRequest(url: url))
    }

}

// MARK: - InfoViewController
extension InfoViewController {
    
    @IBAction func onCloseTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
