//
//  ViewController.swift
//  BindingMVVM
//
//  Created by karlis.stekels on 22/09/2022.
//

import UIKit

class ViewController: UIViewController {
    
    private var loginViewModel = LoginViewModel()
    
    lazy var usernameTextField: UITextField = {
        
        let usernameTextField = BindingTextField()
        usernameTextField.placeholder = "Enter username"
        usernameTextField.backgroundColor = UIColor.lightGray
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.bind { [weak self] text in
            self?.loginViewModel.username.value = text
        }
        
        return usernameTextField
    }()
    
    lazy var passwordTextField: UITextField = {
        
        let passwordTextField = BindingTextField()
        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholder = "Enter password"
        passwordTextField.backgroundColor = UIColor.lightGray
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.bind { [weak self] text in
            self?.loginViewModel.password.value = text
        }
        
        return passwordTextField
        
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewModel.username.bind{ [weak self] text in
            self?.usernameTextField.text = text
        }
        loginViewModel.password.bind { [weak self] text in
            self?.passwordTextField.text = text
        }
        setUpUI()
    }
    
    @objc func login() {
        print(self.loginViewModel.username.value)
        print(self.loginViewModel.password.value)
    }
    
    @objc func fetchLoginInfo() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.loginViewModel.username.value = "frank"
        }
    }

    private func setUpUI() {
        
        let loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = UIColor.gray
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        let fetchLoginInfoButton = UIButton()
        fetchLoginInfoButton.setTitle("Fetch Login Info", for: .normal)
        fetchLoginInfoButton.backgroundColor = UIColor.blue
        fetchLoginInfoButton.addTarget(self, action: #selector(fetchLoginInfo), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [usernameTextField, passwordTextField, loginButton, fetchLoginInfoButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        
        self.view.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
    }

}

