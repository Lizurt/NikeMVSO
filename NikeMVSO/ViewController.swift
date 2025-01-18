//
//  ViewController.swift
//  NikeMVSO
//
//  Created by Павел Бондарева on 17.11.2024.
//

import UIKit

// первый экран

class ViewController: UIViewController {
    
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnJoinUs: UIButton!
    @IBOutlet weak var backgroundImg: UIImageView!

    
    let gradientLayer = CAGradientLayer()
    let colors: [CGColor] = [
        UIColor.clear,
        UIColor.black
    ].map { $0.cgColor }
    
    let locations: [Float] = [0.5, 1]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        btnJoinUs.layer.cornerRadius = 25
        
        btnSignIn.layer.cornerRadius = 25
        btnSignIn.layer.borderWidth = 2
        btnSignIn.layer.borderColor = UIColor.white.cgColor
        
        gradientLayer.frame = backgroundImg.bounds
        gradientLayer.colors = colors
        gradientLayer.locations = locations.map { NSNumber(value: $0) }
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        backgroundImg.layer.addSublayer(gradientLayer)
        
       
    }


}
    // второй экран

class GetStartedViewController: UIViewController {
    
    @IBOutlet weak var btnGetStarted: UIButton!
    @IBOutlet weak var labelText: UITextView!
    
    let downGradientLayer = CAGradientLayer()
    let upGradientLayer = CAGradientLayer()
    
    let colors: [CGColor] = [
        UIColor.clear,
        UIColor.black
    ].map { $0.cgColor }
    
    let downLocations: [Float] = [0.2, 1]
    let upLocations: [Float] = [0.6, 1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        btnGetStarted.layer.cornerRadius = 25
        
        downGradientLayer.frame = self.view.bounds
        downGradientLayer.colors = colors
        downGradientLayer.locations = downLocations.map { NSNumber(value: $0) }
        downGradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        downGradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        view.layer.addSublayer(downGradientLayer)
        
        upGradientLayer.frame = self.view.bounds
        upGradientLayer.colors = colors
        upGradientLayer.locations = upLocations.map { NSNumber(value: $0) }
        upGradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
        upGradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        
        view.layer.addSublayer(upGradientLayer)
        
        view.bringSubviewToFront(btnGetStarted)
        view.bringSubviewToFront(labelText)
        
       
    }
    
    
}



// Третий экран со списком

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var buttonNext: UIButton!
          
    struct Interests {
        let title: String
        let imageName: String
    }
    
    // собрали лейблы и названия картинок в одну структуру (что-то похожее на словарь)
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
        return data.count // количество строк
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95 // ширина ячейки
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
 
