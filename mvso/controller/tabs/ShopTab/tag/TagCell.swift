//
//  TagCell.swift
//  figmaNike
//
//  Created by Илья Шаталов on 09.12.2024.
//

import Foundation
import UIKit

class TagCell: UICollectionViewCell {
    @IBOutlet weak var tagImageView: UIImageView!
    @IBOutlet weak var tagNameLabel: UILabel!
    
    func configure(with tag: Tag) {
        tagNameLabel.text = tag.name
        tagImageView.image = UIImage(named: tag.imageName)
    }
}
