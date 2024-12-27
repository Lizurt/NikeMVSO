//
//  ProductInShopCell.swift
//  figmaNike
//
//  Created by Илья Шаталов on 26.11.2024.
//

import Foundation
import UIKit

class ProductCard: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tagField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    @IBOutlet weak var loadingImageIndicator: UIActivityIndicatorView!
    
    func configure(with card: Card) {
        if (card.imageUrl != ""){
            self.imageView.image = UIImage(named: "placeholder")
            loadingImageIndicator.startAnimating()
            tagField.text = card.tag
            nameField.text = card.name
            descriptionField.text = card.description
            priceField.text = "US$\(card.price)"
            // Load image in background thread
            if let url = URL(string: card.imageUrl) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                            self.imageView.image = UIImage(data: data)
                            self.loadingImageIndicator.stopAnimating()
                        }
                    }
                }
            }
        }
    }
    
}
