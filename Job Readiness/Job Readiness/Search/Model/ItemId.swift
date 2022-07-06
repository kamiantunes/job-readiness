//
//  ListIdItems.swift
//  Job Readiness
//
//  Created by Kamilla Mylena Teixeira Antunes on 04/07/22.
//

import Foundation

struct ItemIdResponse: Codable {
    let content: [ItemId]
}

struct ItemId: Codable {
    let id: String
    var idUrl: String? {
        id + ","
    }
    let position: Int
    let type: String
}


//"id": "MLB2146294763",
//            "position": 1,
//            "type": "ITEM"
