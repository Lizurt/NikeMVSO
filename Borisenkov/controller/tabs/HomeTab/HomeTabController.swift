//
//  HomeTabController.swift
//  figmaNike
//
//  Created by Илья Шаталов on 25.11.2024.
//

import Foundation
import UIKit

class HomeTabController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!

        let data = [
            ("Air Jordan XXXVI", "US$185", UIImage(named: "air-jordan-xxxvi-basketball-shoes-1D0pp7-removebg-preview 1")),
            ("Item 2", "Price 2", UIImage(named: "air-jordan-xxxvi-basketball-shoes-1D0pp7-removebg-preview 1")),
            ("Item 2", "Price 2", UIImage(named: "air-jordan-xxxvi-basketball-shoes-1D0pp7-removebg-preview 1")),
            ("Item 2", "Price 2", UIImage(named: "air-jordan-xxxvi-basketball-shoes-1D0pp7-removebg-preview 1")),
            ("Item 2", "Price 2", UIImage(named: "air-jordan-xxxvi-basketball-shoes-1D0pp7-removebg-preview 1")),
            ("Item 2", "Price 2", UIImage(named: "air-jordan-xxxvi-basketball-shoes-1D0pp7-removebg-preview 1"))
        ]

        override func viewDidLoad() {
            super.viewDidLoad()
            collectionView.dataSource = self
            collectionView.delegate = self
            self.navigationItem.hidesBackButton = true
        }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return data.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
            let itemData = data[indexPath.item]
            if let image = itemData.2 {
                cell.configure(with: image, name: itemData.0, price: itemData.1)
            }
            return cell
        }
    
}
