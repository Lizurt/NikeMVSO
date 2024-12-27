//
//  CustomTextField.swift
//  Borisenkov
//
//  Created by User on 08.12.2024.
//

import UIKit
import MaterialComponents.MaterialTextFields

class CustomTempCodeField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // Story Board Initialization
    required init?(coder aDecorder: NSCoder) {
        super.init(coder: aDecorder)
        // Add custom code here
        firstTextFieldplaceHolder()
    }
    private func firstTextFieldplaceHolder() {
        
        let placeholderString = NSAttributedString(string: "12345678")
        self.attributedPlaceholder = placeholderString
        
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}

class CustomTextField: UITextField {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}

class CustomDateField: UITextField {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
