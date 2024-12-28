//
//  ViewController.swift
//  nike
//
//  Created by CSF on 02.11.2024.
//

import UIKit

class WelcomeScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.goToMainScreen()
        }
    }

    private func goToMainScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Идентификатор целевого View Controller'а
        let mainVC = storyboard.instantiateViewController(withIdentifier: "WelcomeScreen")

        // Установить его как rootViewController
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.window?.rootViewController = mainVC
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}
// https://www.youtube.com/watch?v=eWGu3hcL3ww

/*
class DataCollectionViewCell: UICollectionViewCell {
    
}

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func didRecieveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        <#code#>
    }
}

extension ViewController: UICollectionViewDataSource {
    
}

extension ViewController: UICollectionViewFlowLayout {
    
}
*/
