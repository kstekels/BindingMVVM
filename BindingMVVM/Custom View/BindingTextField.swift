//
//  BindingTextField.swift
//  BindingMVVM
//
//  Created by karlis.stekels on 22/09/2022.
//

import Foundation
import UIKit

class BindingTextField: UITextField {
    
    var textChanged: (String) -> Void = { _ in }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        addTarget(self, action: #selector(textfieldDidChange), for: .editingChanged)
    }
    
    func bind(callback: @escaping (String) -> Void) {
        textChanged = callback
    }
    
    @objc func textfieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            textChanged(text)
        }
    }
}
