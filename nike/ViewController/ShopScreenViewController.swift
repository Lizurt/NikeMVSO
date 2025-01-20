//
//  ShopScreenViewController.swift
//  nike
//
//  Created by Pasha on 23.12.2024.
//

import UIKit

class ShopScreenViewController: UIViewController {
    
    @IBOutlet weak var slider: UIView!
    @IBOutlet weak var menSectionButton: UIButton!
    @IBOutlet weak var womenSectionButton: UIButton!
    @IBOutlet weak var kidsSectionButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    private var selectedSectionButton: UIButton?
    
    private var shopCarouselItemProvider = ShopCarouselItemStaticProvider()
    private var carouselItems: [ShopCarouselItem] = []
    
    // todo: move to provider
    private let imageList = ["Image10", "Image11", "Image10"]
    private let labelList = ["New & Featured", "Shoes", "Clothes"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carouselItems = shopCarouselItemProvider.provide()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Shop"
        
        collectionView.dataSource = self
        collectionView.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        
        self.view.tintColor = UIColor.lightGray
        selectedSectionButton = menSectionButton
        menSectionButton.setTitleColor(.black, for: .normal)
        
        menSectionButton.addTarget(self, action: #selector(menTapped), for: .touchUpInside)
        womenSectionButton.addTarget(self, action: #selector(womenTapped), for: .touchUpInside)
        kidsSectionButton.addTarget(self, action: #selector(kidsTapped), for: .touchUpInside)
    }
    
    @objc private func menTapped() {
        moveSlider(to: menSectionButton)
    }
    
    @objc private func womenTapped() {
        moveSlider(to: womenSectionButton)
    }
    
    @objc private func kidsTapped() {
        moveSlider(to: kidsSectionButton)
    }
    
    private func moveSlider(to button: UIButton) {
        selectedSectionButton?.setTitleColor(.lightGray, for: .normal)
        
        selectedSectionButton = button
        selectedSectionButton?.setTitleColor(.black, for: .normal)
        
        let buttonWidth = button.frame.width
        let buttonX = button.frame.origin.x
        
        UIView.animate(withDuration: 0.3) {
            self.slider.frame.origin.x = buttonX
            self.slider.frame.size.width = buttonWidth
        }
    }
}

extension ShopScreenViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carouselItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellShop", for: indexPath) as! CollectionViewShopCell
        
        let item = carouselItems[indexPath.item]
        cell.imageCell.image = UIImage(named: item.imageName)
        cell.labelCell.text = item.title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 220, height: 290)
    }
}

extension ShopScreenViewController: UICollectionViewDelegate {
    
}

extension ShopScreenViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTable", for: indexPath) as! ShopTableViewCell
        
        cell.imageTableCell.image = UIImage(named: imageList[indexPath.row])
        cell.labelTableCell.text = labelList[indexPath.row]
        
        return cell
    }
}
