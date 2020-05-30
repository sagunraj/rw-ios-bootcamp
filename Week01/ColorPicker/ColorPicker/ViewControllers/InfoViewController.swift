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
    
    var isColorModeRGB: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupWebView()
    }
    
    private func setupWebView() {
        let urlString = isColorModeRGB ? "https://en.wikipedia.org/wiki/RGB_color_model"
            : "https://en.wikipedia.org/wiki/HSL_and_HSV"
        guard let url = URL(string: urlString) else { return }
        webView.load(URLRequest(url: url))
    }
    
    private func setupView() {
        closeButton.setTitle("", for: .normal)
        closeButton.setImage(#imageLiteral(resourceName: "close.pdf"), for: .normal)
        closeButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        closeButton.tintColor = .black
    }

}

// MARK: - InfoViewController
extension InfoViewController {
    
    @IBAction func onCloseTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
