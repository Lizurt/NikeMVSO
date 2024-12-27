//
//  ViewController.swift
//  Borisenkov
//
//  Created by User on 18.11.2024.
//

import UIKit
import MaterialComponents.MaterialTextFields

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    let logoImageView = UIImageView()
    let titleLabel = UILabel()
    let codeTextField = MDCOutlinedTextField()
    let firstNameTextField = MDCOutlinedTextField()
    let surnameTextField = MDCOutlinedTextField()
    let passwordTextField = MDCOutlinedTextField()
    let dobButton = MDCButton()
    let continueButton = UIButton(type: .system) // Кнопка "Продолжить"
    
    let condition1ImageView = UIImageView()
    let condition2ImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupHeader()
        setupTextFields()
        setupPasswordCriteria()
        setupDOBInputField()
        setupContinueButton()
        
        passwordTextField.delegate = self
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldChanged), for: .editingChanged)
        
        codeTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        firstNameTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        surnameTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        dobTextField?.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    func setupHeader() {
        logoImageView.image = UIImage(named: "nike-black")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = "Now let's make you a Nike Member."
        titleLabel.font = UIFont(name: "Inter-Regular_Medium", size: 33)
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let headerStackView = UIStackView(arrangedSubviews: [logoImageView, titleLabel])
        headerStackView.axis = .vertical
        headerStackView.alignment = .leading
        headerStackView.spacing = 0
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(headerStackView)
        
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setupTextFields() {
        codeTextField.label.text = "Code"
        codeTextField.placeholder = "Enter the code"
        codeTextField.frame = CGRect(x: 35, y: 280, width: view.frame.width - 70, height: 60)
        codeTextField.setOutlineColor(UIColor(red: 142/255, green: 142/255, blue: 142/255, alpha: 1.0), for: .normal)
        codeTextField.keyboardType = UIKeyboardType.numberPad
        codeTextField.containerRadius = 12
        
        view.addSubview(codeTextField)
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        firstNameTextField.label.text = "First Name"
        firstNameTextField.placeholder = "Enter your first name"
        firstNameTextField.setOutlineColor(UIColor(red: 142/255, green: 142/255, blue: 142/255, alpha: 1.0), for: .normal)
        firstNameTextField.containerRadius = 12
        
        surnameTextField.label.text = "Surname"
        surnameTextField.placeholder = "Enter your surname"
        surnameTextField.setOutlineColor(UIColor(red: 142/255, green: 142/255, blue: 142/255, alpha: 1.0), for: .normal)
        surnameTextField.containerRadius = 12
        
        stackView.addArrangedSubview(firstNameTextField)
        stackView.addArrangedSubview(surnameTextField)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: codeTextField.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            firstNameTextField.heightAnchor.constraint(equalToConstant: 60),
            surnameTextField.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        passwordTextField.label.text = "Password"
        passwordTextField.placeholder = "Enter your password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.frame = CGRect(x: 35, y: 440, width: view.frame.width - 70, height: 60)
        passwordTextField.setOutlineColor(UIColor(red: 142/255, green: 142/255, blue: 142/255, alpha: 1.0), for: .normal)
        passwordTextField.containerRadius = 12
        view.addSubview(passwordTextField)
    }
    
    func setupPasswordCriteria() {
        condition1ImageView.image = UIImage(systemName: "xmark.circle.fill")
        condition1ImageView.tintColor = .systemRed
        condition1ImageView.translatesAutoresizingMaskIntoConstraints = false
        condition1ImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        condition1ImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        condition2ImageView.image = UIImage(systemName: "xmark.circle.fill")
        condition2ImageView.tintColor = .systemRed
        condition2ImageView.translatesAutoresizingMaskIntoConstraints = false
        condition2ImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        condition2ImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        let condition1StackView = UIStackView(arrangedSubviews: [condition1ImageView, createCriteriaLabel(text: "Minimum of 8 characters")])
        condition1StackView.axis = .horizontal
        condition1StackView.spacing = 8
        
        let condition2StackView = UIStackView(arrangedSubviews: [condition2ImageView, createCriteriaLabel(text: "Uppercase, lowercase letters and one number")])
        condition2StackView.axis = .horizontal
        condition2StackView.spacing = 8
        
        let criteriaStackView = UIStackView(arrangedSubviews: [condition1StackView, condition2StackView])
        criteriaStackView.axis = .vertical
        criteriaStackView.spacing = 5
        criteriaStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(criteriaStackView)
        
        NSLayoutConstraint.activate([
            criteriaStackView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            criteriaStackView.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            criteriaStackView.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor)
        ])
    }
    
    func createCriteriaLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }
    
    @objc func passwordTextFieldChanged() {
        let password = passwordTextField.text ?? ""
        
        let isLengthValid = password.count >= 8
        let hasRequiredCharacters = password.range(of: "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d).*$", options: .regularExpression) != nil
        
        updateCheckmark(for: condition1ImageView, isChecked: isLengthValid)
        updateCheckmark(for: condition2ImageView, isChecked: hasRequiredCharacters)
        
        validateForm()
    }
    
    func updateCheckmark(for imageView: UIImageView, isChecked: Bool) {
        let imageName = isChecked ? "checkmark.circle.fill" : "xmark.circle.fill"
        imageView.image = UIImage(systemName: imageName)
        imageView.tintColor = isChecked ? .systemGreen : .systemRed
    }
    
    func setupDOBInputField() {
        let dobTextField = MDCOutlinedTextField()
        dobTextField.label.text = "Date of Birth"
        dobTextField.placeholder = "Select your date of birth"
        dobTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dobTextField)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = Date()
        datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -100, to: Date())
        
        dobTextField.inputView = datePicker
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(didTapDone))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        
        dobTextField.inputAccessoryView = toolbar
        dobTextField.setOutlineColor(UIColor(red: 142/255, green: 142/255, blue: 142/255, alpha: 1.0), for: .normal)
        dobTextField.containerRadius = 12
        
        self.dobTextField = dobTextField
        self.datePicker = datePicker
        
        NSLayoutConstraint.activate([
            dobTextField.topAnchor.constraint(equalTo: condition2ImageView.bottomAnchor, constant: 20),
            dobTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            dobTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            dobTextField.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private var dobTextField: MDCOutlinedTextField?
    private var datePicker: UIDatePicker?
    
    @objc private func didTapDone() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        if let datePicker = self.datePicker {
            dobTextField?.text = dateFormatter.string(from: datePicker.date)
        }
        
        view.endEditing(true)
           validateForm()
    }
    
    func setupContinueButton() {
        continueButton.setTitle("Continue", for: .normal)
        continueButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        continueButton.backgroundColor = UIColor.lightGray
        continueButton.layer.cornerRadius = 12
        continueButton.setTitleColor(.white, for: .normal)
//        continueButton.isEnabled = false
        continueButton.isEnabled = true
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        view.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            continueButton.topAnchor.constraint(equalTo: dobTextField!.bottomAnchor, constant: 30),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            continueButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func didTapContinue() {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "StayInTheKnow") as? UIViewController
        self.navigationController?.pushViewController(nextVC!, animated: true)
    }

    func validateForm() {
        let isFormFilled = !(codeTextField.text?.isEmpty ?? true) &&
        (codeTextField.text?.count == 8) &&
        !(firstNameTextField.text?.isEmpty ?? true) &&
        !(surnameTextField.text?.isEmpty ?? true) &&
        !(passwordTextField.text?.isEmpty ?? true) &&
        !(dobTextField?.text?.isEmpty ?? true)
        
        let isPasswordValid = condition1ImageView.tintColor == .systemGreen &&
        condition2ImageView.tintColor == .systemGreen
        
        if isFormFilled && isPasswordValid {
            continueButton.isEnabled = true
            continueButton.backgroundColor = UIColor.black
        } else {
//            continueButton.isEnabled = false
            continueButton.isEnabled = true
            continueButton.backgroundColor = UIColor.lightGray
        }
    }
    
    @objc func textFieldChanged() {
        validateForm()
    }
    
    
}



// ------------------------------------------------------
class HideBackButton: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func nextBut(_ sender: UIButton) {
        // Проверяем существование контроллера
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "selectSportsOnboarding") else {
            print("Error: ViewController with identifier 'selectSportsOnboarding' not found.")
            return
        }
        
        // Переходим на следующий экран
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

class GradientWelcomePage: UIImageView {
    private var gradientLayer: CAGradientLayer?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addGradient()
    }
    
    private func addGradient() {
        gradientLayer?.removeFromSuperlayer()
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(1).cgColor]
        gradient.locations = [0.5, 1.0]
        gradient.frame = bounds
        layer.addSublayer(gradient)
        
        gradientLayer = gradient
    }
}

class GradientOnboarding: UIImageView {
    private var gradientLayer: CAGradientLayer?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addGradient()
    }
    
    private func addGradient() {
        gradientLayer?.removeFromSuperlayer()
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.black.withAlphaComponent(1).cgColor, UIColor.black.withAlphaComponent(0.5).cgColor, UIColor.black.withAlphaComponent(0.5).cgColor, UIColor.black.withAlphaComponent(1).cgColor]
        gradient.locations = [0.05, 0.2, 0.8, 1]
        gradient.frame = bounds
        layer.addSublayer(gradient)
        
        gradientLayer = gradient
    }
}

