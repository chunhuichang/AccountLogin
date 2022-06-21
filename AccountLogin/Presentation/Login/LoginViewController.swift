//
//  LoginViewController.swift
//  AccountLogin
//
//  Created by Jill Chang on 2022/6/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let viewModel: LoginVMManager
    
    init(viewModel: LoginVMManager) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(displayP3Red: 224.0/255.0, green: 216.0/255.0, blue: 200.0/255.0, alpha: 1)
    }
}
