//
//  UpdateUserViewController.swift
//  AccountLogin
//
//  Created by Jill Chang on 2022/6/22.
//

import UIKit

class UpdateUserViewController: UIViewController {
    private lazy var timezoneTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Enter timezone"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    private lazy var numberTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Enter number"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    private lazy var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Enter phone"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    private lazy var userInputs: [UIView] = {
        struct Row {
            let label: String
            let textField: UITextField
        }
        
        let rows = [Row(label: "Time Zone:", textField: timezoneTextField), Row(label: "Number", textField: numberTextField), Row(label: "Phone", textField: phoneTextField)]
        
        var views = [UIView]()
        
        for row in rows {
            let label = UILabel()
            label.text = row.label
            label.font = .systemFont(ofSize: 18)
            label.textColor = .systemBlue
            label.translatesAutoresizingMaskIntoConstraints = false
            
            let textfield = row.textField
            let view = UIView()
            
            [label, textfield].forEach { [view] in
                view.addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
            
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: view.topAnchor),
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                label.trailingAnchor.constraint(equalTo: textfield.leadingAnchor, constant: -10),
                label.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                
                textfield.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
                textfield.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                textfield.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
                textfield.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/5)
            ])
            
            views.append(view)
        }
        return views
    }()
    
    private lazy var userInputStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: userInputs)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10.0
        return stackView
    }()
    
    private lazy var updateButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemOrange
        button.setTitle("Update User", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.layer.cornerRadius = 5.0
        button.addTarget(nil, action: #selector(loginAction(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc private func loginAction(_ sender: UIButton) {
        self.viewModel.input.updateUserAction(timezone: timezoneTextField.text, number: numberTextField.text, phone: phoneTextField.text)
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
    
    
    private let viewModel: UpdateUserVMManager
    
    init(viewModel: UpdateUserVMManager) {
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
private extension UpdateUserViewController {
    private func setupUI() {
        self.view.backgroundColor = UIColor(displayP3Red: 224.0/255.0, green: 216.0/255.0, blue: 200.0/255.0, alpha: 1)
        
        [userInputStackView, updateButton, loadingActivity, loadingView].forEach { [superView = self.view] in
            superView?.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            userInputStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50),
            userInputStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            userInputStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            userInputStackView.heightAnchor.constraint(equalToConstant: 210),
            
            updateButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            updateButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            updateButton.heightAnchor.constraint(equalToConstant: 50),
            updateButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
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
private extension UpdateUserViewController {
    private func UIBinding() {
        let output = self.viewModel.output
        
        output.isLoading.binding {[weak self] newValue, _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.showActivityIndicator(newValue ?? false)
            }
        }
        
        output.alertMessage.binding { newValue, _ in
            let alertController = UIAlertController(title: newValue?.0,
                                                    message: newValue?.1, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
