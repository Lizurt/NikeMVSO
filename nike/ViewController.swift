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

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var buttonNext: UIButton!
          
    struct Interests {
        let title: String
        let imageName: String
    }
    
    let data: [Interests] = [
        Interests(title: "Air Max", imageName: "AirMax"),
        Interests(title: "Baseball", imageName: "Baseball"),
        Interests(title: "Big & Tall", imageName: "BigTall"),
        Interests(title: "Cross-Training", imageName: "CrossTraining"),
        Interests(title: "Dance", imageName: "Dance"),
        Interests(title: "Lacrosse", imageName: "Lacrosse"),
        Interests(title: "Maternity", imageName: "Maternity"),
        Interests(title: "N7", imageName: "N7"),
        Interests(title: "Nike Sportswear", imageName: "NikeSportswear")
    ]
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // настройки для кнопки next
        
        buttonNext.frame = CGRect(x: 120, y: 0, width: 150, height: 50)
        buttonNext.frame.size.width = 100
        buttonNext.frame.size.height = 50
        buttonNext.layer.cornerRadius = 25
        buttonNext.backgroundColor = .white
        buttonNext.setTitle("Next", for: .normal)
        buttonNext.setTitleColor(.black, for: .normal)
      
        view.addSubview(buttonNext)
        
        
        table.dataSource = self
        table.delegate = self
    }
    
      
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // функция, которая оставляет кнопку на месте при пролистывании
        buttonNext.frame = CGRect(x: 120, y: 0, width: 150, height: 50)
        buttonNext.frame.origin.y = 750 + scrollView.contentOffset.y
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let interest = data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        cell.label.text = interest.title // ссылка на текст лейбл из cell = данные из структуры (описание)
        cell.iconImageView.image = UIImage(named: interest.imageName)
        cell.selectionStyle = .none
        cell.radioButton.addTarget(self, action: #selector(button_Select(_:)), for: .touchUpInside)

        return cell
        
    }
    
    // функция для того чтобы менять изображение на кнопке при нажатии
    @objc func button_Select(_ sender: UIButton) {
        if sender.isSelected == false {
            sender.setBackgroundImage(UIImage(named: "checkButton"), for: .selected)
            sender.isSelected = true
        } else {
            sender.setBackgroundImage(UIImage(named: "uncheckButton"), for: .selected)
            sender.isSelected = false
        }
    
    }
}
 
