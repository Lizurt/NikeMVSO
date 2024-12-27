//
//  CategoryWithImageViewCell.swift
//  figmaNike
//
//  Created by Илья Шаталов on 09.12.2024.
//

import Foundation
import UIKit

class CategoryWithImageViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
        
    func configure(with category: Category) {
        categoryNameLabel.text = category.name
        categoryImageView.image = UIImage(named: category.imageName)
    }
}
