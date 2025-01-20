//
//  BestSellersCollectionViewController.swift
//  nike
//
//  Created by Pasha on 25.12.2024.
//

import UIKit

class BestSellersScreenViewController: UIViewController {
    
    @IBOutlet weak var bestSellersCollectionView: UICollectionView!
    
    let productsManager: ProductProvider = ProductProvider()
    
    private var products: [Product] = []
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .gray
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
        
        bestSellersCollectionView.dataSource = self
        bestSellersCollectionView.delegate = self
        
        self.productsManager.fetchProducts { result in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                
                switch result {
                case .success(let products):
                    self.products = products
                    self.bestSellersCollectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        bestSellersCollectionView.backgroundColor = .white
        
        self.navigationItem.title = "Best Sellers"
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.tintColor = .darkGray
        
        self.tabBarController?.tabBar.barTintColor = .white
        
    }
    
}

extension UIImageView {
    func setImage(from url: URL, mode: UIView.ContentMode = .scaleAspectFit, completion: ((UIImage) -> Void)? = nil) -> URLSessionDataTask {
        self.contentMode = mode
        
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(indicator)
        
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        indicator.startAnimating()
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data)
            else { return }
            
            DispatchQueue.main.async {
                
                indicator.stopAnimating()
                indicator.removeFromSuperview()
                
                self.image = image
                completion?(image)
            }
        }
        
        task.resume()
        return task
    }
}

extension BestSellersScreenViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        cell.product = self.products[indexPath.item]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2.09
        return CGSize(width: width, height: width * 1.516 )
    }
    
}

extension BestSellersScreenViewController: UICollectionViewDelegate {
    
}
