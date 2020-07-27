//
//  ImageCache.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/19/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

extension UIImageView {
    
    public static var imageStore: [String: UIImage] = [:]
    
    public class func setImage(_ imageURL: URL, completion: @escaping (UIImage) -> Void) {
        let key = imageURL.lastPathComponent
        if let image = imageStore[key] {
            completion(image)
        }
        Networking.sharedInstance.getLogoImage(at: imageURL) { (image, message) in
            guard let image = image else { return }
            imageStore[key] = image
            completion(image)
        }
    }
    
}
