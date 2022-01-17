//
//  LoginViewController.swift
//  GeekBlog
//
//  Created by sangheon on 2022/01/16.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let usernameEmailField:UITextField = {
        return UITextField()
    }()
    
    private let passwordField:UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        return field
    }()
    
    private let loginButton:UIButton = {
        return UIButton()
    }()
    
    private let termsButton:UIButton = {
        return UIButton()
    }()
    
    private let privacyButton:UIButton = {
        return UIButton()
    }()
    
    private let createAccountButton:UIButton = {
        return UIButton()
    }()
    
    private let headerView:UIView = {
        return UIView()
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        view.backgroundColor = .systemBackground
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //Asign Frames
        headerView.frame = CGRect(x: 0,
                                  y: view.safeAreaInsets.top,
                                  width: view.width,
                                  height: 200)
    }
    
    
    
    func addSubViews() {
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(createAccountButton)
        view.addSubview(headerView)
    }
    
    @objc private func didTabLoginButton() {}
    
    @objc private func didTabTermsButton() {}
    
    @objc private func didTabPrivacyButton() {}
    
    @objc private func didTabCreateAccountButton() {}
    
}
