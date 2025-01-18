//
//  WelcomeScreenViewController.swift
//  nike
//
//  Created by Pasha on 18.01.2025.
//

import UIKit

class WelcomeScreenViewController: UIViewController {
    
    @IBOutlet weak var joinUsButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!

    private let fadeToBlackKeyPoints: [Float] = [0.5, 1]
    private let fadeToBlackLayerColors: [CGColor] = [
        UIColor.clear,
        UIColor.black
    ].map { $0.cgColor }
    
    private let buttonCornerRadius: CGFloat = 30
    private let buttonBorderWidth: CGFloat = 1
    private let buttonCornerColor: CGColor = UIColor.white.cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    private func setUpViews() {
        setUpSignInButtonView(
            cornerRadius: buttonCornerRadius,
            borderWidth: buttonBorderWidth,
            borderColor: buttonCornerColor
        )
        
        setUpJoinUsButtonView(
            cornerRadius: buttonCornerRadius,
            borderWidth: buttonBorderWidth,
            borderColor: buttonCornerColor
        )
        
        setUpBackgroundView()
    }
    
    private func setUpSignInButtonView(cornerRadius: CGFloat = 50, borderWidth: CGFloat = 1, borderColor: CGColor = UIColor.white.cgColor) {
        signInButton.layer.cornerRadius = cornerRadius
        signInButton.layer.borderWidth = borderWidth
        signInButton.layer.borderColor = borderColor
    }
    
    private func setUpJoinUsButtonView(cornerRadius: CGFloat = 50, borderWidth: CGFloat = 1, borderColor: CGColor = UIColor.white.cgColor) {
        joinUsButton.layer.cornerRadius = cornerRadius
        joinUsButton.layer.borderWidth = borderWidth
        joinUsButton.layer.borderColor = borderColor
    }
    
    private func setUpBackgroundView() {
        let fadeToBlackLayer = CAGradientLayer()
        fadeToBlackLayer.frame = self.view.frame
        fadeToBlackLayer.colors = fadeToBlackLayerColors
        fadeToBlackLayer.locations = fadeToBlackKeyPoints.map { NSNumber(value: $0) }
        fadeToBlackLayer.startPoint = CGPoint(x: 0.5, y: 0)
        fadeToBlackLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        backgroundImage.layer.addSublayer(fadeToBlackLayer)
    }
}
