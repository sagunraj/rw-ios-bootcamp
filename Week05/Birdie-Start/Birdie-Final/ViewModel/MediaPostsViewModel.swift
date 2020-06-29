//
//  MediaPostsViewModel.swift
//  Birdie-Final
//
//  Created by Sagun Raj Lage on 6/27/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

class MediaPostsViewModel {
    
    let mediaPostsHandler: MediaPostsHandler!
    
    init() {
        mediaPostsHandler = MediaPostsHandler.shared
        mediaPostsHandler.getPosts()
    }
    
    func getPostType(_ post: MediaPost) -> PostType {
        guard let _ = post as? ImagePost else { return .text }
        return .image
    }
    
}
