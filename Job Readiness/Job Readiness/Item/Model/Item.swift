//
//  Item.swift
//  Job Readiness
//
//  Created by Kamilla Mylena Teixeira Antunes on 02/07/22.
//

import Foundation

struct Response: Codable {
    let code: Int
    var item: Item
    
    enum CodingKeys: String, CodingKey {
        case code
        case item = "body"
    }
}

// MARK: - Body
struct Item: Codable {
    let id: String
    let title: String
    let subtitle: String?
    var price: Double?
    var priceFormated: String? {
        "R$ " + String(price ?? 0.0)
    }
    let thumbnail: String?
    let secureThumbnail: String?
    let pictures: [Picture]
    let dateCreated, lastUpdated: String?
    var isFavorited: Bool = false

    enum CodingKeys: String, CodingKey {
        case id, title, subtitle
        case price, pictures
        case thumbnail
        case secureThumbnail = "secure_thumbnail"
        case dateCreated = "date_created"
        case lastUpdated = "last_updated"
    }
}

// MARK: - Picture
struct Picture: Codable {
    let id: String
    let url: String?
    let secureURL: String
    let size, maxSize, quality: String

    enum CodingKeys: String, CodingKey {
        case id, url
        case secureURL = "secure_url"
        case size
        case maxSize = "max_size"
        case quality
    }
}

struct Description: Codable {
    let descriptionText: String?
    
    enum CodingKeys: String, CodingKey {
        case descriptionText = "plain_text"
    }
}
