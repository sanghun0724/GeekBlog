//
//  DatabaseManager.swift
//  GeekBlog
//
//  Created by sangheon on 2022/01/16.
//

import FirebaseDatabase

public class DatabaseManager {
    static let shared = DatabaseManager()
    
    // MARK: - Public
    
    /// Check if username and is available
    /// - Parameters
    ///     - email:String representing email
    ///     - username: String representing username
    
    public func canCreateNewUser(with email:String,username:String,completion:(Bool)->Void) {
        
    }
}
