//
//  CategoryProvider.swift
//  figmaNike
//
//  Created by Илья Шаталов on 09.12.2024.
//

import Foundation
import UIKit

struct Category {
    let name: String
    let imageName: String
}

class CategoryProvider {
    static let shared = CategoryProvider()
    
    let categories: [Category]  = [
        Category(name: "All", imageName: "newCategory"),
        Category(name: "Hoodies & Sweatshirts", imageName: "hoodieCategory"),
        Category(name: "Accessories", imageName: "accesoiresCategory"),
        Category(name: "T-Shirts", imageName: "tshirtsCategory"),
        Category(name: "Jackets", imageName: "jacketsCategory"),
        Category(name: "Shoes", imageName: "sneakersCategory")
        ]
    
    func getCategories() -> [Category]{
        return categories
    }
}
