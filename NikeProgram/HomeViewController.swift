//
//  HomeViewController.swift
//  NikeProgram
//
//  Created by Олеся on 25.12.2024.
//

// пятый экран (Home)

import UIKit

class CollectionViewInterestsCell: UICollectionViewCell {
    
    @IBOutlet weak var imageInterestCell: UIImageView!
    
    @IBOutlet weak var labelInterestCell: UILabel!
    
}

class HomeCollectionViewShopCell: UICollectionViewCell {

    @IBOutlet weak var imageShopCell: UIImageView!
}

    
class HomeViewController: UIViewController {

    

    @IBOutlet weak var interestsCollectionView: UICollectionView!
    @IBOutlet weak var shoeCollectionView: UICollectionView!
    
    var interestCollectionCell: [CollectionItem] = [
        CollectionItem(image: UIImage(named: "ImageHome1")!, title: "Running"),
        CollectionItem(image: UIImage(named: "ImageHome2")!, title: "Stretching") ]

    let shoeCollectionCell = ["whiteShoe", "blackShoe", "blueShoe"]
    
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interestsCollectionView.dataSource = self
        interestsCollectionView.delegate = self
        
        shoeCollectionView.dataSource = self
        shoeCollectionView.delegate = self

      
    }
                       
}



extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ сollectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if сollectionView == interestsCollectionView {
            return interestCollectionCell.count
        }
        else
        {
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

extension HomeViewController: UICollectionViewDelegate {
    
}
