//
//  ListIdItems.swift
//  Job Readiness
//
//  Created by Kamilla Mylena Teixeira Antunes on 04/07/22.
//

import Foundation

struct ListIdItem: Codable {
    let content: [IdItem]
}

struct IdItem: Codable {
    let id: String
    let position: Int
    let type: String
}
