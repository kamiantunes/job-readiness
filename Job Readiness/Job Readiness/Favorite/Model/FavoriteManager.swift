//
//  Favorite.swift
//  Job Readiness
//
//  Created by Kamilla Mylena Teixeira Antunes on 05/07/22.
//

import Foundation

struct FavoriteManager {
    static var itemsFavorited: [String] = []
    private let userDefaults = UserDefaults.standard
    
    func getFavorites() -> [String] {
        userDefaults.object(forKey: "favorited") as? [String] ?? []
    }
    
    func addFavorited(with id: String) {
        FavoriteManager.itemsFavorited.append(id)
        updateFavorites()
    }
    
    func removeFavorited(with id: String) {
        FavoriteManager.itemsFavorited.removeAll(where: {$0 == id})
        updateFavorites()
    }
    
    private func updateFavorites() {
        userDefaults.set(FavoriteManager.itemsFavorited, forKey: "favorited")
    }
    
    func consultFavorited(with id: String) -> Bool {
        FavoriteManager.itemsFavorited.contains(where: {$0 == id})
    }
    
    func countFavorites() -> Int {
        FavoriteManager.itemsFavorited.count
    }
    
    func getIdsForPath() -> String {
        var string = String()
        
        for item in FavoriteManager.itemsFavorited {
            let idItem = item == FavoriteManager.itemsFavorited.last ? item : item + ","
            string += idItem
        }
        
        return string
    }
}
