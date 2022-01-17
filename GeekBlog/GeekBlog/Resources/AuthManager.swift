//
//  AuthManager.swift
//  GeekBlog
//
//  Created by sangheon on 2022/01/16.
//

import FirebaseAuth

public class AuthManager {
    static let shared = AuthManager()
    
    // MARK: - Public
    
    public func registerNewUser(username:String,email:String,passwords:String) {
        /*
         - Check if username is available
         
         */
    }
    
    public func loginUser(username:String?,email:String?,password:String,completion:@escaping ((Bool) -> Void)) {
        if let email = email {
            //email login
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                
                completion(true)
            }
        }
        else if let username = username {
            //username login
            print(username)
        }
    }
}
