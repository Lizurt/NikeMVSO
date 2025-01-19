//
//  ShopController.swift
//  NikeProgram
//
//  Created by Pasha on 23.12.2024.
//

import UIKit

class ShopController: UIViewController {
    
    @IBOutlet weak var slider: UIView!
    @IBOutlet weak var Men: UIButton!
    @IBOutlet weak var Women: UIButton!
    @IBOutlet weak var Kids: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    private var selectedButton: UIButton?
    
    private var shopCarouselItemProvider = ShopCarouselItemStaticProvider()
    private var carouselItems: [ShopCarouselItem] = []
    
    let imageList = ["Image10", "Image10", "Image10"]
    let labelList = ["New & Featured", "Shoes", "Clothes"]
    
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
        selectedButton = Men
        Men.setTitleColor(.black, for: .normal)
        
        Men.addTarget(self, action: #selector(menTapped), for: .touchUpInside)
        Women.addTarget(self, action: #selector(womenTapped), for: .touchUpInside)
        Kids.addTarget(self, action: #selector(kidsTapped), for: .touchUpInside)
    }
    
    @objc func menTapped() {
        moveSlider(to: Men)
    }
    
    @objc func womenTapped() {
        moveSlider(to: Women)
    }
    
    @objc func kidsTapped() {
        moveSlider(to: Kids)
    }
    
    func moveSlider(to button: UIButton) {
        // устанавливаем цвет предыдущей кнопки как серый
        selectedButton?.setTitleColor(.lightGray, for: .normal)
        
        // устанавливаем текущей кнопки как черный
        selectedButton = button
        selectedButton?.setTitleColor(.black, for: .normal)
        
        let buttonWidth = button.frame.width
        let buttonX = button.frame.origin.x
        
        UIView.animate(withDuration: 0.3) {
            self.slider.frame.origin.x = buttonX
            self.slider.frame.size.width = buttonWidth
        }
    }
}

extension ShopController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
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
extension ShopController: UICollectionViewDelegate {
    
}

extension ShopController: UITableViewDataSource, UITableViewDelegate {
    
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
