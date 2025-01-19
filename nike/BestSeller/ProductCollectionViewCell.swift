//
//  ProductCollectionViewCell.swift
//  nike
//
//  Created by Pasha on 19.01.2025.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var soldout: UILabel!
    @IBOutlet weak var bestseller: UILabel!
    @IBOutlet weak var price: UILabel!

    private var dataTask: URLSessionDataTask? = nil
    
    var product: Product? {
        didSet {
            guard let product else { return }
            
            self.title.text = product.brand
            self.subtitle.text = product.productName
            
            self.soldout.isHidden = product.quantity > 0
            self.bestseller.isHidden = !product.isBestseller
            
            self.price.text = String(format: "$%0.2f", product.price)
            
            if let url = URL(string: product.imageUrl) {
                self.dataTask?.cancel()
                self.dataTask = self.logo.setImage(from: url) { img in
                    self.dataTask = nil
                }
            }
         }
    }
        
    override func prepareForReuse() {
        super.prepareForReuse()
        self.logo.image = nil
    }
}
