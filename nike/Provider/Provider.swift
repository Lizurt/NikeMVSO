
//
//  Provider.swift
//  nike
//
//  Created by Pasha on 19.01.2025.
//

protocol Provider {
    associatedtype T
    
    func provide() -> T
}
