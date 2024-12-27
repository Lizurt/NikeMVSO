//
//  ProductCell.swift
//  figmaNike
//
//  Created by Илья Шаталов on 25.11.2024.
//

import Foundation
import UIKit

class ProductCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var priceField: UITextField!

    func configure(with image: UIImage, name: String, price: String) {
        imageView.image = image
        nameField.text = name
        priceField.text = price
    }
}
