//
//  SignInViewController.swift
//  Thoughts
//
//  Created by sangheon on 2022/01/26.
//

import UIKit
import SnapKit

class SignInViewController: UIViewController {
    
    // HeaderView
    private let headerView = SignInHeaderView()
    // Eamil Field
    private let emailField:UITextField = {
        let field = UITextField()
        field.keyboardType = .emailAddress
        field.leftViewMode = .always
        field.autocapitalizationType = .none
        field.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: 50)) // 약간 옆에 공간주기
        field.placeholder = "Email Address"
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = 8
        field.layer.masksToBounds = true
        return field
    }()
    
    //password Field
    private let passwordField:UITextField = {
        let field = UITextField()
        field.keyboardType = .emailAddress
        field.leftViewMode = .always
        field.autocapitalizationType = .none
        field.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: 50)) // 약간 옆에 공간주기
        field.placeholder = "Password"
        field.isSecureTextEntry = true
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = 8
        field.layer.masksToBounds = true
        return field
    }()
    //Sign In Button
    private let signInButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    
    //Create Account
    private let createAccountButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBackground
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(.link, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign In"
        view.backgroundColor = .systemBackground
        //        present(PayWallViewController(),animated: true)
        view.addSubview(headerView)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signInButton)
        view.addSubview(createAccountButton)
        
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccount), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureUI()
    }
    
    private func configureUI() {
        headerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaInsets)
            make.height.equalTo(view.height/4)
        }
        
        emailField.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(20)
            make.top.equalTo(headerView.snp.bottom)
            make.height.equalTo(50)
        }
        passwordField.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(20)
            make.top.equalTo(emailField.snp.bottom).offset(10)
            make.height.equalTo(50)
        }
        signInButton.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(20)
            make.top.equalTo(passwordField.snp.bottom).offset(10)
            make.height.equalTo(50)
        }
        createAccountButton.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(20)
            make.top.equalTo(signInButton.snp.bottom).offset(40)
            make.height.equalTo(50)
        }
        
    }
    
    @objc func didTapSignIn() {
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
                  return
              }
        AuthManager.shared.signIn(email: email, password: password) { [weak self] success in
            guard success else {
                return
            }
            DispatchQueue.main.async {
                UserDefaults.standard.set(email, forKey: "email")
                let vc = TabBarViewController()
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc,animated: true)
            }
        }
    }
    
    @objc func didTapCreateAccount() {
        let vc = SignUpViewController()
        vc.title = "create Account"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
