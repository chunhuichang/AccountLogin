//
//  LoginViewController.swift
//  AccountLogin
//
//  Created by Jill Chang on 2022/6/21.
//

import UIKit

class LoginViewController: UIViewController {
    private lazy var userNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Enter user name"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Enter password"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemOrange
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.layer.cornerRadius = 5.0
        button.addTarget(nil, action: #selector(loginAction(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc private func loginAction(_ sender: UIButton) {
        self.viewModel.input.loginAction(userName: userNameTextField.text, password: passwordTextField.text)
    }
    
    private lazy var loadingActivity: UIActivityIndicatorView = {
        let loadingActivity = UIActivityIndicatorView()
        loadingActivity.hidesWhenStopped = true
        loadingActivity.style = .large
        loadingActivity.color = .white
        loadingActivity.backgroundColor = .darkGray
        loadingActivity.layer.cornerRadius = 10
        return loadingActivity
    }()
    
    private lazy var loadingView: UIView = {
        return UIView()
    }()
    
    public var viewModel: LoginVMManager
    
    init(viewModel: LoginVMManager) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.UIBinding()
    }
}

// MARK: UI Setting
private extension LoginViewController {
    private func setupUI() {
        self.view.backgroundColor = UIColor(displayP3Red: 224.0/255.0, green: 216.0/255.0, blue: 200.0/255.0, alpha: 1)
        
        [userNameTextField, passwordTextField, loginButton, loadingActivity, loadingView].forEach { [superView = self.view] in
            superView?.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50),
            userNameTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            userNameTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 150),
            passwordTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 350),
            loginButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            loadingActivity.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loadingActivity.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            loadingActivity.widthAnchor.constraint(equalToConstant: 80),
            loadingActivity.heightAnchor.constraint(equalTo: loadingActivity.widthAnchor),
            
            loadingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    private func showActivityIndicator(_ show: Bool) {
        if show {
            loadingActivity.startAnimating()
            loadingView.isHidden = false
        } else {
            loadingActivity.stopAnimating()
            loadingView.isHidden = true
        }
    }
}

// MARK: UI Binding
private extension LoginViewController {
    private func UIBinding() {
        let output = self.viewModel.output
        
        output.isLoading.binding {[weak self] newValue, _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.showActivityIndicator(newValue ?? false)
            }
        }
        
        output.alertMessage.binding(trigger: false) { newValue, _ in
            let alertController = UIAlertController(title: newValue?.0,
                                                    message: newValue?.1, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
