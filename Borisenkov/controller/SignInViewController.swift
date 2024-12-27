//
//  SignInViewController.swift
//  figmaNike
//
//  Created by Илья Шаталов on 18.11.2024.
//

import Foundation
import UIKit

class SignInViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func goToHomeScreen(_ sender: UIButton) {
            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
            if let homeViewController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController {
                    self.navigationController?.pushViewController(homeViewController, animated: true)
                }
        
        }
    
    
}

class GradientImageView: UIImageView {
    private var gradientLayer: CAGradientLayer?

    override func layoutSubviews() {
        super.layoutSubviews()
        addGradient()
    }

    private func addGradient() {
        // Remove any existing gradient layer
        gradientLayer?.removeFromSuperlayer()

        // Create a new gradient layer
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.6).cgColor]
        gradient.locations = [0.5, 1.0]
        gradient.frame = bounds
        layer.addSublayer(gradient)

        // Store a reference to remove later if needed
        gradientLayer = gradient
    }
}
