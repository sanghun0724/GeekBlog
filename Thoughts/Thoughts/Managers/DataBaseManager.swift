//
//  DataBaseManager.swift
//  Thoughts
//
//  Created by sangheon on 2022/01/26.
//

import Foundation
import FirebaseFirestore

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let database = Firestore.firestore()
    
    private init() {}
    
    public func insert(blogPost:BlogPost,user: User,completion: @escaping (Bool) -> Void) {
        
    }
    
    public func getAllPosts(completion: @escaping ([BlogPost]) -> Void) {
        
    }
    
    public func getPostForUser(user: User,completion: @escaping ([BlogPost]) -> Void) {
        
    }
    
    public func insertUser(user: User,completion: @escaping (Bool) -> Void) {
        
    }
}
