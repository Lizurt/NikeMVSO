//
//  SplashScreenViewController.swift
//  nike
//
//  Created by Pasha on 18.01.2025.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
    @IBOutlet weak var logoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.logoImage.alpha = 0.0
        
        // fixme: ужас
        UIView.animate(withDuration: 0.5, animations: {
            self.logoImage.alpha = 1.0
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.goToMainScreen()
            }
        }
    }
    
    private func goToMainScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "welcomeScreen")
        
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.window?.rootViewController = mainViewController
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}
