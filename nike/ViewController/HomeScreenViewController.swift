//
//  HomeViewController.swift
//  nike
//
//  Created by Pasha on 19.01.2025.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    @IBOutlet weak var interestsCollectionView: UICollectionView!
    @IBOutlet weak var shoeCollectionView: UICollectionView!
    
    // todo: move to provider
    var interestCollectionCell: [CollectionItem] = [
        CollectionItem(title: "Running", image: UIImage(named: "ImageHome1")!),
        CollectionItem(title: "Stretching", image: UIImage(named: "ImageHome2")!)
    ]
    
    let shoeCollectionCell = ["whiteShoe", "blackShoe", "blueShoe"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interestsCollectionView.dataSource = self
        interestsCollectionView.delegate = self
        
        shoeCollectionView.dataSource = self
        shoeCollectionView.delegate = self
    }
}

extension HomeScreenViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ сollectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if сollectionView == interestsCollectionView {
            return interestCollectionCell.count
        } else {
            return shoeCollectionCell.count
        }
    }
    
    func collectionView(_ сollectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if сollectionView == interestsCollectionView {
            
            let cell = сollectionView.dequeueReusableCell(withReuseIdentifier: "cellInterest", for: indexPath) as! CollectionViewInterestsCell
            
            let item = interestCollectionCell[indexPath.item]
            cell.imageInterestCell.image = item.image
            cell.labelInterestCell.text = item.title
            
            return cell
        } else {
            let cell = сollectionView.dequeueReusableCell(withReuseIdentifier: "cellShoe", for: indexPath) as! HomeCollectionViewShopCell
            
            cell.imageShopCell.image = UIImage(named: shoeCollectionCell[indexPath.item])
            
            return cell
        }
    }
    
    func collectionView(_ сollectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 250)
    }
}

extension HomeScreenViewController: UICollectionViewDelegate {
    
}
