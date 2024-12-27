//
//  FavouriteTabController.swift
//  figmaNike
//
//  Created by Илья Шаталов on 02.12.2024.
//

import Foundation
import UIKit

class FavouriteTabController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var favoritesCollectionView: UICollectionView!
    
    var favoriteCards: [Card] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesCollectionView.delegate = self
        favoritesCollectionView.dataSource = self
        
        loadFavorites()
        NotificationCenter.default.addObserver(self, selector: #selector(favoritesChanged), name: FavoriteManager.favoritesChangedNotification, object: nil)
    }
    
    @IBAction func favoritesChanged() {
        loadFavorites()
    }
    
    func loadFavorites() {
        favoriteCards = FavoriteManager.shared.getFavorites()
        favoritesCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCard", for: indexPath) as! ProductCard
        let card = favoriteCards[indexPath.row]
        cell.configure(with: card)
        cell.favoriteButton.tag = indexPath.row
        return cell
    }
    
    // Action for the favorite button
    @IBAction func addToFavoritesButtonTapped(_ sender: UIButton) {
        let card = favoriteCards[sender.tag]
        FavoriteManager.shared.removeFavorite(card)
    }
}
