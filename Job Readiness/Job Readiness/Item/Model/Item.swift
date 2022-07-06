//
//  Item.swift
//  Job Readiness
//
//  Created by Kamilla Mylena Teixeira Antunes on 02/07/22.
//

import Foundation

struct Items: Codable {
    let code: Int
    var item: Item
    
    enum CodingKeys: String, CodingKey {
        case code
        case item = "body"
    }
}

struct Item: Codable {
    let id: String
    let title: String
    let subtitle: String?
    let thumbnail: String?
    let pictures: [Picture]
    var price: Double
    
    var isFavorited: Bool = false

    enum CodingKeys: String, CodingKey {
        case id, title, subtitle, price, thumbnail, pictures
    }
}

struct Picture: Codable {
    let id: String
    let url: String?

    enum CodingKeys: String, CodingKey {
        case id, url
    }
}

struct Description: Codable {
    let descriptionText: String?
    
    enum CodingKeys: String, CodingKey {
        case descriptionText = "plain_text"
    }
}
