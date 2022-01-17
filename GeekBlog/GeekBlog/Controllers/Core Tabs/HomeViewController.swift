//
//  ViewController.swift
//  GeekBlog
//
//  Created by sangheon on 2022/01/16.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("goooood")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenticated()
//        do {
//           try FirebaseAuth.Auth.auth().signOut()
//        } catch {
//            print("failed to sign out")
//        }
    }
    
    private func handleNotAuthenticated() {
        //check auth status
        if Auth.auth().currentUser == nil {
            // Show Login
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
    }
}

