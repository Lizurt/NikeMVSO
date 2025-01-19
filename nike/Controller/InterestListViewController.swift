//
//  InterestsListViewController.swift
//  nike
//
//  Created by CSF on 02.11.2024.
//

import UIKit


struct Interest {
    let title: String
    let imageName: String
}

class InterestItemViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var radioButton: UIButton!
}

class InterestListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var interestsTableView: UITableView!
    @IBOutlet weak var buttonNext: UIButton!
    
    private final let ROW_HEIGHT: CGFloat = 95
    
    private let interestItems: [Interest] = [
        Interest(title: "Air Max", imageName: "AirMax"),
        Interest(title: "Baseball", imageName: "Baseball"),
        Interest(title: "Big & Tall", imageName: "BigTall"),
        Interest(title: "Cross-Training", imageName: "CrossTraining"),
        Interest(title: "Dance", imageName: "Dance"),
        Interest(title: "Lacrosse", imageName: "Lacrosse"),
        Interest(title: "Maternity", imageName: "Maternity"),
        Interest(title: "N7", imageName: "N7"),
        Interest(title: "Nike Sportswear", imageName: "NikeSportswear")
    ]
    
    private var chosenItemsCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toggleNextButton(available: false)

        interestsTableView.dataSource = self
        interestsTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interestItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ROW_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let interest = interestItems[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InterestItemViewCell
        
        cell.label.text = interest.title
        cell.iconImageView.image = UIImage(named: interest.imageName)
        cell.selectionStyle = .none
        cell.radioButton.addTarget(self, action: #selector(button_Select(_:)), for: .touchUpInside)

        return cell
    }
    
    @objc func button_Select(_ sender: UIButton) {
        if sender.isSelected == false {
            sender.setBackgroundImage(UIImage(named: "checkButton"), for: .selected)
            sender.isSelected = true
            chosenItemsCount += 1
        } else {
            sender.setBackgroundImage(UIImage(named: "uncheckButton"), for: .selected)
            sender.isSelected = false
            chosenItemsCount -= 1
        }

        toggleNextButton(available: isNextButtonAvailable())
    }
    
    private func isNextButtonAvailable() -> Bool {
        return chosenItemsCount > 0
    }
    
    private func toggleNextButton(available: Bool) {
        if available {
            showNextButton()
        } else {
            hideNextButton()
        }
    }
    
    private func showNextButton(duration: Float = 0.3) {
        UIView.animate(withDuration: 0.3) {
            self.buttonNext.alpha = 1.0
            self.buttonNext.isEnabled = true
            self.buttonNext.isHidden = false
        }
    }
    
    private func hideNextButton(duration: Float = 0.3) {
        UIView.animate(withDuration: TimeInterval(duration), animations: {
            self.buttonNext.alpha = 0.0
        }) { _ in
            self.buttonNext.isEnabled = false
            self.buttonNext.isHidden = true
        }
    }
}
