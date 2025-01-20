//
//  ShopCarouselItemProvider.swift
//  nike
//
//  Created by Pasha on 19.01.2025.
//

private var carouselItems: [ShopCarouselItem] = [
    ShopCarouselItem(title: "Best Sellers", imageName: "Image13"),
    ShopCarouselItem(title: "Featured in Nike Air", imageName: "Image14")
]

protocol ShopCarouselItemProvider {
    
    func provide() -> [ShopCarouselItem]
}

class ShopCarouselItemStaticProvider: ShopCarouselItemProvider {
    
    func provide() -> [ShopCarouselItem] {
        return carouselItems
    }
}

class ShopCarouselItemBackendProvider: ShopCarouselItemProvider {
    
    func provide() -> [ShopCarouselItem] {
        // todo: add implementation for backend DAO calls
        return []
    }
}
