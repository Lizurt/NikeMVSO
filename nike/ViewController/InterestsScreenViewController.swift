//
//  InterestsListViewController.swift
//  nike
//
//  Created by CSF on 02.11.2024.
//

import UIKit

class InterestItemViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var radioButton: UIButton!
}

class InterestsScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var interestsTableView: UITableView!
    @IBOutlet weak var buttonNext: UIButton!
    
    private final let interestsProvider = InterestsStaticProvider()
    private final let rowHeight: CGFloat = 95
    private final var chosenInterestsCount: Int = 0
    private var interests: [Interest] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interests = interestsProvider.provide()
        
        toggleNextButton(available: false)
        
        interestsTableView.dataSource = self
        interestsTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interests.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let interest = interests[indexPath.row]
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
            chosenInterestsCount += 1
        } else {
            sender.setBackgroundImage(UIImage(named: "uncheckButton"), for: .selected)
            sender.isSelected = false
            chosenInterestsCount -= 1
        }

        toggleNextButton(available: isNextButtonAvailable())
    }
    
    private func isNextButtonAvailable() -> Bool {
        return chosenInterestsCount > 0
    }
    
    private func toggleNextButton(available: Bool) {
        if available {
            showNextButton()
        } else {
            hideNextButton()
        }
    }
    
    private func showNextButton(duration: Float = 0.2) {
        UIView.animate(withDuration: 0.3) {
            self.buttonNext.alpha = 1.0
            self.buttonNext.isEnabled = true
            self.buttonNext.isHidden = false
        }
    }
    
    private func hideNextButton(duration: Float = 0.2) {
        UIView.animate(withDuration: TimeInterval(duration), animations: {
            self.buttonNext.alpha = 0.0
        }) { _ in
            self.buttonNext.isEnabled = false
            self.buttonNext.isHidden = true
        }
    }
}
