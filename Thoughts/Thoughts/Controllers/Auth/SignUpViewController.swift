//
//  SignUpViewController.swift
//  Thoughts
//
//  Created by sangheon on 2022/01/26.
//

import UIKit

class SignUpViewController: UIViewController {
    
    // HeaderView
    private let headerView = SignInHeaderView()
    // Eamil Field
    private let nameField:UITextField = {
        let field = UITextField()
        field.leftViewMode = .always
        field.autocapitalizationType = .none
        field.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: 50)) // 약간 옆에 공간주기
        field.placeholder = "Pull Name"
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = 8
        field.layer.masksToBounds = true
         return field
    }()
    
    private let emailField:UITextField = {
        let field = UITextField()
        field.keyboardType = .emailAddress
        field.autocapitalizationType = .none
        field.leftViewMode = .always
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
        field.autocapitalizationType = .none
        field.leftViewMode = .always
        field.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: 50)) // 약간 옆에 공간주기
        field.placeholder = "Password"
        field.isSecureTextEntry = true
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = 8
        field.layer.masksToBounds = true
         return field
    }()
    //Sign In Button
    private let signUpButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Account"
        view.backgroundColor = .systemBackground
//        present(PayWallViewController(),animated: true)
        view.addSubview(headerView)
        view.addSubview(emailField)
        view.addSubview(nameField)
        view.addSubview(passwordField)
        view.addSubview(signUpButton)

        
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
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
        
        nameField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(headerView.snp.bottom)
            make.height.equalTo(50)
        }
        
        emailField.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(20)
            make.top.equalTo(nameField.snp.bottom).offset(10)
            make.height.equalTo(50)
        }
        
        passwordField.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(20)
            make.top.equalTo(emailField.snp.bottom).offset(10)
            make.height.equalTo(50)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(20)
            make.top.equalTo(passwordField.snp.bottom).offset(10)
            make.height.equalTo(50)
        }
    }
    
    @objc func didTapSignUp() {
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty ,
        let name = nameField.text, !name.isEmpty else {
            return
        }
        
        //Create User
        AuthManager.shared.signUp(email: email, password: password) { [weak self] success in
            if success {
                //Update databse
                let newUser = User(name: name, email: email, profilePictureUrl: nil)
                DatabaseManager.shared.insert(user: newUser) { inserted in
                    guard inserted else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        let vc = TabBarViewController()
                        vc.modalPresentationStyle = .fullScreen
                        self?.present(vc, animated: true)
                    }
                }
            } else {
                print("Failed to create account")
            }
        }
        
        
    }
    
    @objc func didTapCreateAccount() {
        let vc = SignUpViewController()
        vc.title = "create Account"
        navigationController?.pushViewController(vc, animated: true)
    }
   
}
