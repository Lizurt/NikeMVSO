//
//  LaunchVIewController.swift
//  figmaNike
//
//  Created by Илья Шаталов on 18.11.2024.
//

import Foundation
import UIKit

class LaunchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Задержка в 2 секунды перед переходом на главный экран
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.showMainScreen()
                }
    }
    
    func showMainScreen() {
            // Идентификатор Storyboard для главного экрана
            let mainStoryboard = UIStoryboard(name: "SignIn", bundle: nil)
            if let mainViewController = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as? UIViewController {
                self.present(mainViewController, animated: true, completion: nil)
            }
        }
}
