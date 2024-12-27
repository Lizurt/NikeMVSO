//
//  FavouriteManager.swift
//  figmaNike
//
//  Created by Илья Шаталов on 02.12.2024.
//

import Foundation
import UIKit

class FavoriteManager {
    static let shared = FavoriteManager()
    
    private let favoritesKey = "favorites"
    static let favoritesChangedNotification = Notification.Name("favoritesChanged")
        
        func addFavorite(_ card: Card) {
            print("ADD TO FAVS")
            var favorites = getFavorites()
            print(card.name)
            if !favorites.contains(where: { $0.id == card.id }) {
                favorites.append(card)
                saveFavorites(favorites)
            }
        }
        
        func removeFavorite(_ card: Card) {
            print("REMOVE FROM FAVS")
            print(card.description)
            var favorites = getFavorites()
            favorites.removeAll { $0.id == card.id }
            saveFavorites(favorites)
        }
        
        func getFavorites() -> [Card] {
            if let data = UserDefaults.standard.data(forKey: favoritesKey),
               let favorites = try? JSONDecoder().decode([Card].self, from: data) {
                return favorites
            }
            return []
        }
        
        private func saveFavorites(_ favorites: [Card]) {
            if let data = try? JSONEncoder().encode(favorites) {
                UserDefaults.standard.set(data, forKey: favoritesKey)
            }
            NotificationCenter.default.post(name: FavoriteManager.favoritesChangedNotification, object: nil)
        }
        
        func isFavorite(_ card: Card) -> Bool {
            return getFavorites().contains(where: { $0.id == card.id })
        }
}
