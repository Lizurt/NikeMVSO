//
//  CustomTableViewController.swift
//  Borisenkov
//
//  Created by User on 07.12.2024.
//

import UIKit

// Протокол для передачи информации о нажатии кнопки
protocol CustomTableViewCellDelegate: AnyObject {
    func didTapButton(in cell: CustomTableViewCell)
}

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var myButton: UIButton! // Кнопка в ячейке
    
    weak var delegate: CustomTableViewCellDelegate?

    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        delegate?.didTapButton(in: self)
    }
}

class CustomTableViewController: UITableViewController, CustomTableViewCellDelegate {
    
    let items = [
        ("What sports, brands and collections are you interested in?", nil),
        ("Training & Gym", "training-gym"),
        ("Jordan", "jordan"),
        ("NikeLab", "nikelab"),
        ("Tennis", "tennis"),
        ("Nike For Boys", "nike-for-boys"),
        ("Nike For Girls", "nike-for-girls"),
        ("SNKRS", "snkrs"),
        ("Skateboarding", "skateboarding"),
        ("Big & Tall", "big-tall"),
        ("Swimming", "swimming"),
        ("Air Force 1", "air-force-1"),
        ("Nike Sportswear", "nike-sportswear"),
        ("Lifestyle", "lifestyle"),
        ("Running", "running")
    ]
        
    // Кнопка "Next"
    var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-Regular_Medium", size: 20)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.isHidden = true // Изначально скрыта
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Добавляем кнопку на экран
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 55),
            nextButton.widthAnchor.constraint(equalToConstant: 150),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
        
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    // Обработчик кнопки "Next"
    @objc func nextButtonTapped() {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController;
        self.navigationController?.pushViewController(vc!, animated: true)
        }
    
    // Количество строк в таблице
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    // Настройка ячеек
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        
        let (text, imageName) = items[indexPath.row]
        
        cell.textLabel?.text = text
        
        if indexPath.row == 0 {
            tableView.rowHeight = 130
            tableView.separatorStyle = .none
            cell.myButton.isHidden = true
            
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = UIFont(name: "Inter-Regular_Medium", size: 28)
            cell.textLabel?.numberOfLines = 3
            cell.imageView?.image = nil
            cell.selectionStyle = .none
        } else {
            tableView.separatorStyle = .singleLine
            tableView.separatorColor = .white
            tableView.rowHeight = 80
            cell.myButton.isHidden = false

            cell.imageView?.image = UIImage(named: imageName ?? "")
            cell.imageView?.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
            cell.imageView?.contentMode = .scaleAspectFit
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = UIFont(name: "Inter-Regular_Medium", size: 25)
            cell.selectionStyle = .none
            
            // Устанавливаем делегат для ячейки
            cell.delegate = self
        }
        
        return cell
    }

    // Метод делегата: вызов при нажатии кнопки в ячейке
    func didTapButton(in cell: CustomTableViewCell) {
        // Проверяем, есть ли хотя бы одна кнопка с isSelected = true
        var isAnyButtonSelected = false
        
        for visibleCell in tableView.visibleCells {
            if let customCell = visibleCell as? CustomTableViewCell {
                if customCell.myButton.isSelected {
                    isAnyButtonSelected = true
                    break
                }
            }
        }
        
        // Обновляем состояние кнопки "Next"
        nextButton.isHidden = !isAnyButtonSelected
    }
}
