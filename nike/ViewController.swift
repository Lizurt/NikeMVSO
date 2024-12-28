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
