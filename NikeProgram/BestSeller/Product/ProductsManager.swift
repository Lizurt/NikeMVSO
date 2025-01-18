//
//  ProductsManager.swift
//  NikeProgram
//
//  Created by Олеся Бондарева on 30.11.2024.
//

import Foundation

class ProductsManager {
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        let url = URL(string: "https://github.com/pbukhon/VSU_lectures/blob/3df168d37a838a519d76f5e69bb677016918c5ff/products.json?raw=true")!
        APIManager.sharedInstance.get(withUrl: url, completion: completion)
    }
}
