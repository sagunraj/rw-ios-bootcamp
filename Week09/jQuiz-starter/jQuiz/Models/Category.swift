//
//  Category.swift
//  jQuiz
//
//  Created by Sagun Raj Lage on 7/26/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

struct Category: Codable {

    let id: Int
    let title: String
    let createdAt: String
    let updatedAt: String
    let cluesCount: Int
    
    public enum CodingKeys: String, CodingKey {
        case id
        case title
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case cluesCount = "clues_count"
    }
    
}
