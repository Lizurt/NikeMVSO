//
//  ProductsProvider.swift
//  nike
//
//  Created by Pasha on 30.12.2024.
//

import Foundation

class ProductProvider {
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        let url = URL(string: "https://github.com/pbukhon/VSU_lectures/blob/3df168d37a838a519d76f5e69bb677016918c5ff/products.json?raw=true")!
        HttpClient.sharedInstance.get(withUrl: url, completion: completion)
    }
}
