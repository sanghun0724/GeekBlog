//
//  ProfileViewController.swift
//  Thoughts
//
//  Created by sangheon on 2022/01/26.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(didTapSignOut))
    }
    
    
    @objc private func  didTapSignOut() {
        
    }

}
