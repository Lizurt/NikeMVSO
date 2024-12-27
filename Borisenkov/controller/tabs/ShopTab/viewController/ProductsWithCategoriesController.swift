//
//  ShopTabController.swift
//  figmaNike
//
//  Created by Илья Шаталов on 26.11.2024.
//

struct Card: Codable {
    let id: String
    let name: String
    let description: String
    let price: Int
    var imageUrl: String
    let tag: String
    let category: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, price
        case imageUrl = "image_url"
        case tag, category
    }
}

import Foundation
import UIKit

class ProductsWithCategoriesController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var cardsCollectionView: UICollectionView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    @IBOutlet weak var navigator: UINavigationItem!
    @IBOutlet weak var cardsLoadingIndicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var underlineView: UIView!
    var category: Category?
    var tag: Tag?
    
    var categories: [Category] = []
    
    var allCards = [Card]()
    
    var cards = [Card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigator.backButtonTitle = ""
        cardsCollectionView.dataSource = self
        cardsCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        categories = CategoryProvider.shared.getCategories()
        if (self.tag != nil ) {
            self.navigator.title = self.tag!.name
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
                    if (self.tag != nil ) {
                        self.navigator.title = self.tag!.name
                        self.allCards = self.allCards.filter { $0.tag == self.tag!.name }
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let firstCell = categoriesCollectionView.cellForItem(at: IndexPath(item: 0, section: 0)) {
            let underlineFrame = firstCell.convert(firstCell.bounds, to: self.view)
            underlineView.frame.origin.x = underlineFrame.origin.x
            underlineView.frame.size.width = firstCell.frame.size.width
        }
    }
    
    
    // Categories collection view methods
    func numberOfItemsInCategoriesCollectionView() -> Int {
        return categories.count
    }
    
    func cellForItemInCategoriesCollectionView(at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoryViewCell", for: indexPath) as! CategoryViewCell
        cell.categoryName.text = categories[indexPath.row].name
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == categoriesCollectionView {
            updateUnderlinePosition()
        }
    }
    
    func updateUnderlinePosition() {
        guard let indexPath = categoriesCollectionView.indexPathsForSelectedItems?.first,
              let selectedCell = categoriesCollectionView.cellForItem(at: indexPath) else { return }
        let underlineFrame = selectedCell.convert(selectedCell.bounds, to: self.view)
        UIView.animate(withDuration: 0.1) {
            self.underlineView.frame.origin.x = underlineFrame.origin.x
            self.underlineView.frame.size.width = selectedCell.frame.size.width
        }
    }
    
    func didSelectItemInCategoriesCollectionView(at indexPath: IndexPath) {
        let selectedCategory = categories[indexPath.row].name
        guard let selectedCell = categoriesCollectionView.cellForItem(at: indexPath) else { return }
        UIView.animate(withDuration: 0.1, animations: {
            let underlineFrame = selectedCell.convert(selectedCell.bounds, to: self.view)
            self.underlineView.frame.origin.x = underlineFrame.origin.x
            self.underlineView.frame.size.width = selectedCell.frame.size.width
        })
        updateCards(for: selectedCategory)
        updateUnderlinePosition()
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == categoriesCollectionView {
            updateUnderlinePosition()
        }
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
        if collectionView == categoriesCollectionView {
            return numberOfItemsInCategoriesCollectionView()
        } else if collectionView == cardsCollectionView {
            return numberOfItemsInCardsCollectionView()
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoriesCollectionView {
            return cellForItemInCategoriesCollectionView(at: indexPath)
        } else if collectionView == cardsCollectionView {
            return cellForItemInCardsCollectionView(at: indexPath)
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoriesCollectionView {
            didSelectItemInCategoriesCollectionView(at: indexPath)
        }
    }
    
    func updateCards(for category: String) {
        if (category == "All") {
            cards = allCards
        }
        else {
            cards = allCards.filter { $0.category == category }
        }
        cardsCollectionView.reloadData()
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
