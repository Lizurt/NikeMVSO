//
//  ProductsForCategoryController.swift
//  figmaNike
//
//  Created by Илья Шаталов on 09.12.2024.
//

import Foundation
import UIKit

class ProductsForCategoryController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var cardsCollectionView: UICollectionView!
    
    @IBOutlet weak var navigator: UINavigationItem!
    @IBOutlet weak var cardsLoadingIndicator: UIActivityIndicatorView!
    
    var category: Category?
    
    var allCards = [Card]()
    
    var cards = [Card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigator.backButtonTitle = ""
        cardsCollectionView.dataSource = self
        cardsCollectionView.delegate = self
        if (self.category != nil ) {
            self.navigator.title = self.category!.name
        }
        fetchCardsData()
    }
    
    
    func fetchCardsData() {
        cardsLoadingIndicator.startAnimating()
        let urlString = "https://github.com/saved2223/nikeMobileRepo/blob/main/db.json?raw=true"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                self.allCards = try JSONDecoder().decode([Card].self, from: data)
                DispatchQueue.main.async {
                    if (self.category != nil && self.category!.name != "All") {
                        self.allCards = self.allCards.filter { $0.category == self.category!.name }
                    }
                    self.cards = self.allCards
                    self.cardsLoadingIndicator.stopAnimating()
                    self.cardsCollectionView.reloadData()
                }
            } catch let error {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    
    
    func numberOfItemsInCardsCollectionView() -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  10
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
    
    func cellForItemInCardsCollectionView(at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cardsCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductCard", for: indexPath) as! ProductCard
        let card = cards[indexPath.row]
        let isFavorite = FavoriteManager.shared.isFavorite(card)
        cell.configure(with: card)
        cell.favoriteButton.tag = indexPath.row
        if (isFavorite) {
            cell.favoriteButton.isSelected = true
        }
        else {
            cell.favoriteButton.isSelected = false
        }
        cell.favoriteButton.addTarget(self, action: #selector(addToFavoritesButtonTapped(_:)), for: .touchUpInside)
        return cell
    }
    
    
    // Conforming to UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItemsInCardsCollectionView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return cellForItemInCardsCollectionView(at: indexPath)
    }
    
    // Action for the favorite button
    @IBAction func addToFavoritesButtonTapped(_ sender: UIButton) {
        let card = cards[sender.tag]
        if FavoriteManager.shared.isFavorite(card) {
            FavoriteManager.shared.removeFavorite(card)
            sender.isSelected = false
        } else {
            FavoriteManager.shared.addFavorite(card)
            sender.isSelected = true
        }
    }
}
