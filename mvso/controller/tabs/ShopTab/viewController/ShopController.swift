//
//  ShopController.swift
//  figmaNike
//
//  Created by Илья Шаталов on 09.12.2024.
//

import UIKit

class ShopController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet weak var genderCollection: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tagView: UICollectionView!
    @IBOutlet weak var underlineView: UIView!
    
    let genders: [Gender] = [
        Gender(name: "Man"),
        Gender(name: "Woman"),
        Gender(name: "Kids")
    ]
    
    var categories: [Category] = []
    var tags: [Tag] = []
    private var selectedGenderIndex: IndexPath = IndexPath(item: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Настройка делегатов и источников данных
        genderCollection.dataSource = self
        genderCollection.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tagView.dataSource = self
        tagView.delegate = self
        
        // Загрузка категорий и тегов
        categories = CategoryProvider.shared.getCategories()
        tags = TagProvider.shared.getTags()
        
        // Настройка навигации
        self.navigationItem.backButtonTitle = ""
        UINavigationBar.appearance().tintColor = .black
        self.navigationItem.backBarButtonItem?.tintColor = .black
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Установка полоски для начального выбранного элемента (первой категории)
        updateUnderlinePosition(animated: false)
    }
    
    // MARK: - Полоска под выбранной категорией
    
    private func updateUnderlinePosition(animated: Bool) {
        guard let selectedCell = genderCollection.cellForItem(at: selectedGenderIndex) as? GenderCell else { return }
        
        // Получение текста первой категории
        let text = selectedCell.genderName.text ?? ""
        
        // Вычисление ширины текста на основе его атрибутов
        let textWidth = (text as NSString).size(withAttributes: [.font: selectedCell.genderName.font]).width
        
        // Обновление полоски
        let firstTextFrame = selectedCell.genderName.convert(selectedCell.genderName.bounds, to: self.view)
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.underlineView.frame.origin.x = firstTextFrame.origin.x
                self.underlineView.frame.size.width = textWidth
            }
        } else {
            self.underlineView.frame.origin.x = firstTextFrame.origin.x
            self.underlineView.frame.size.width = textWidth
        }
    }
    
    // MARK: - UICollectionView DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tagView {
            return tags.count
        } else if collectionView == genderCollection {
            return genders.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tagView {
            let cell = tagView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell
            let tag = tags[indexPath.row]
            cell.configure(with: tag)
            return cell
        } else if collectionView == genderCollection {
            let cell = genderCollection.dequeueReusableCell(withReuseIdentifier: "GenderCell", for: indexPath) as! GenderCell
            let gender = genders[indexPath.row]
            cell.configure(with: gender)
            cell.genderName.textColor = indexPath == selectedGenderIndex ? .label : .gray
            return cell
        }
        return UICollectionViewCell()
    }
    
    // MARK: - UICollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == genderCollection {
            // Обновление выбранного индекса
            selectedGenderIndex = indexPath
            
            // Обновление цветов текста
            for cell in genderCollection.visibleCells {
                if let genderCell = cell as? GenderCell {
                    genderCell.genderName.textColor = .gray
                }
            }
            if let selectedCell = genderCollection.cellForItem(at: indexPath) as? GenderCell {
                selectedCell.genderName.textColor = .label
            }
            
            // Обновление положения и размера полоски
            updateUnderlinePosition(animated: true)
        } else if collectionView == tagView {
            // Логика для tagView
            let tag = tags[indexPath.row]
            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
            if let productVC = storyboard.instantiateViewController(withIdentifier: "ProductsWithCategoriesController") as? ProductsWithCategoriesController {
                productVC.tag = tag
                self.navigationController?.pushViewController(productVC, animated: true)
            }
        }
    }
    
    // MARK: - UITableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableCell", for: indexPath) as! CategoryWithImageViewCell
        let category = categories[indexPath.row]
        cell.configure(with: category)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        if let productVC = storyboard.instantiateViewController(withIdentifier: "ProductsForCategoryController") as? ProductsForCategoryController {
            productVC.category = category
            self.navigationController?.pushViewController(productVC, animated: true)
        }
    }
}
