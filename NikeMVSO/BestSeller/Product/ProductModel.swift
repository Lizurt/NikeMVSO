//
//  ProductModel.swift
//  NikeMVSO
//
//  Created by Павел Бондарева on 30.11.2024.
//

import Foundation

struct Product: Codable { // Заменим Decodable на Codable, чтобы можно было и сохранять объект
    var brand: String
    var productName: String
    var price: Double
    var quantity: Int
    var imageUrl: String
    var isLiked: Bool
    var isBestseller: Bool
    
    // Добавим вычисляемое свойство id
    var id: String {
        // Создаем уникальный id из комбинации brand и productName
        return "\(brand)_\(productName)"
    }
    
    enum CodingKeys: String, CodingKey {
        case brand
        case productName = "product_name"
        case price
        case quantity = "items_left"
        case imageUrl = "image_url"
        case isLiked = "is_liked"
        case isBestseller = "is_bestseller"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.brand = try container.decode(String.self, forKey: .brand)
        self.productName = try container.decode(String.self, forKey: .productName)
        self.price = try container.decode(Double.self, forKey: .price)
        self.quantity = try container.decode(Int.self, forKey: .quantity)
        self.imageUrl = try container.decode(String.self, forKey: .imageUrl)
        self.isLiked = try container.decode(Bool.self, forKey: .isLiked)
        self.isBestseller = try container.decode(Bool.self, forKey: .isBestseller)
    }
    
    // Добавим encode для поддержки Codable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(brand, forKey: .brand)
        try container.encode(productName, forKey: .productName)
        try container.encode(price, forKey: .price)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(imageUrl, forKey: .imageUrl)
        try container.encode(isLiked, forKey: .isLiked)
        try container.encode(isBestseller, forKey: .isBestseller)
    }
}

//struct Product: Decodable {
//    var brand: String
//    var productName: String
//    var price: Double
//    var quantity: Int
//    var imageUrl: String
//    var isLiked: Bool
//    var isBestseller: Bool
//    
//    enum CodingKeys: String, CodingKey {
//        case brand
//        case productName = "product_name"
//        case price
//        case items_left
//        case image_url
//        case is_liked, is_bestseller
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.brand = try container.decode(String.self, forKey: .brand)
//        self.productName = try container.decode(String.self, forKey: .productName)
//        self.price = try container.decode(Double.self, forKey: .price)
//        self.quantity = try container.decode(Int.self, forKey: .items_left)
//        self.imageUrl = try container.decode(String.self, forKey: .image_url)
//        self.isLiked = try container.decode(Bool.self, forKey: .is_liked)
//        self.isBestseller = try container.decode(Bool.self, forKey: .is_bestseller)
//    }
//}
