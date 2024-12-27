//
//  GenderCell.swift
//  figmaNike
//
//  Created by Илья Шаталов on 14.12.2024.
//

import Foundation
import UIKit


struct Gender {
    let name: String
}

class GenderCell: UICollectionViewCell {
    @IBOutlet weak var genderName: UILabel!
    
    func configure(with gender: Gender) {
        genderName.text = gender.name
    }
}
