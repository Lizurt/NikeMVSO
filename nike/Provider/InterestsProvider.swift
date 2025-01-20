//
//  InterestsDAO.swift
//  nike
//
//  Created by Pasha on 19.01.2025.
//

private let interestItems: [Interest] = [
    Interest(title: "Air Max", imageName: "AirMax"),
    Interest(title: "Baseball", imageName: "Baseball"),
    Interest(title: "Big & Tall", imageName: "BigTall"),
    Interest(title: "Cross-Training", imageName: "CrossTraining"),
    Interest(title: "Dance", imageName: "Dance"),
    Interest(title: "Lacrosse", imageName: "Lacrosse"),
    Interest(title: "Maternity", imageName: "Maternity"),
    Interest(title: "N7", imageName: "N7"),
    Interest(title: "Nike Sportswear", imageName: "NikeSportswear")
]

protocol InterestsProvider {
    
    func provide() -> [Interest]
}

class InterestsStaticProvider: InterestsProvider {
    
    func provide() -> [Interest] {
        return interestItems
    }
}

class InterestsBackendProvider: InterestsProvider {
    
    func provide() -> [Interest] {
        // todo: implement client-side communication with backend DAO
        return []
    }
}
