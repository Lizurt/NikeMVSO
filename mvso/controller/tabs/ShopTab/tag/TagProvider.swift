//
//  TagProvider.swift
//  figmaNike
//
//  Created by Илья Шаталов on 09.12.2024.
//

import Foundation
import UIKit

struct Tag {
    let name: String
    let imageName: String
}

class TagProvider {
    static let shared = TagProvider()
    
    let tags: [Tag]  = [
        Tag(name: "Bestseller", imageName: "bestSellerTag"),
        Tag(name: "Must-have", imageName: "MustHaveTag")
        ]
    
    func getTags() -> [Tag]{
        return tags
    }
}
