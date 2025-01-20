//
//  GetStartedScreenViewController.swift
//  nike
//
//  Created by Pasha on 18.01.2025.
//

import UIKit

class GetStartedScreenViewController: UIViewController {
    
    @IBOutlet weak var gradientView: UIView!
    
    private let fadeToBlackKeyPoints: [Float] = [0, 0.15, 0.5, 1]
    private let fadeToBlackLayerColors: [CGColor] = [
        UIColor.black,
        UIColor.black,
        UIColor.clear,
        UIColor.black
    ].map { $0.cgColor }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBackgroundView()
    }
    
    private func setUpBackgroundView() {
        let fadeToBlackLayer = CAGradientLayer()
        fadeToBlackLayer.frame = self.view.frame
        fadeToBlackLayer.colors = fadeToBlackLayerColors
        fadeToBlackLayer.locations = fadeToBlackKeyPoints.map { NSNumber(value: $0) }
        fadeToBlackLayer.startPoint = CGPoint(x: 0.5, y: 0)
        fadeToBlackLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        gradientView.layer.addSublayer(fadeToBlackLayer)
    }
}
