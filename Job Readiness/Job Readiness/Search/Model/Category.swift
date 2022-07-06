//
//  Categorie.swift
//  Job Readiness
//
//  Created by Kamilla Mylena Teixeira Antunes on 04/07/22.
//

import Foundation

struct Category : Codable {
    let categoryId: String
    let categoryName: String
    
    enum CodingKeys: String, CodingKey {
        case categoryId = "category_id"
        case categoryName = "category_name"
    }
}
