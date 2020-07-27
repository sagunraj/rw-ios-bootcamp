//
//  QuestionCodable.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

struct Clue: Codable {
    
    let id: Int
    let answer: String
    let question: String
    let value: Int?
    let airdate: String
    let createdAt: String
    let updatedAt: String
    let categoryId: Int
    let gameId: Int?
    let invalidCount: Int?
    let category: Category
    
    public enum CodingKeys: String, CodingKey {
        case id
        case answer
        case question
        case value
        case airdate
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case categoryId = "category_id"
        case gameId = "game_id"
        case invalidCount = "invalid_count"
        case category
    }
    
}
