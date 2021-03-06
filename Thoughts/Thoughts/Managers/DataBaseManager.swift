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
    
    public func insert(blogPost:BlogPost,email: String,completion: @escaping (Bool) -> Void) {
        let userEmail = email
            .replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: "_")
        
        let data :[String : Any] = [
            "id" : blogPost.identifier,
            "title": blogPost.title,
            "body": blogPost.text,
            "created":blogPost.timestamp,
            "headerImageUrl": blogPost.headerImageUrl?.absoluteString ?? ""
        ]
        
        database
            .collection("users")
            .document(userEmail)
            .collection("posts")
            .document(blogPost.identifier)
            .setData(data) { error in
                completion(error==nil)
            }
    }
    
    public func getAllPosts(completion: @escaping ([BlogPost]) -> Void) {
        // Get all users
        // From each user, get post  -> this is how to "getAllPosts"
        var result:[BlogPost] = []
        database
            .collection("users")
            .getDocuments { [weak self] snapshot,error in //하나의 documents가 아닌 모든 documents 가져오기
                guard let documents = snapshot?.documents.compactMap({$0.data()}),
                      error == nil else {
                    return
                }
                guard let self = self else { return }
                
                let emails:[String] = documents.compactMap({ $0["email"] as? String})
                
                guard !emails.isEmpty else {
                    print("email is empty")
                    completion([])
                    return
                }
                
                
                let group = DispatchGroup()
                
                for email in emails {
                    group.enter()
                    self.getPost(for: email) { userPosts in
                        defer {
                            group.leave()
                        }
                        result.append(contentsOf: userPosts)
                    }
                }
                
                group.notify(queue: .global()) {
                    print("Feed posts \(result.count)")
                    completion(result)
                }
            }
    }
    
    public func getPost(for email: String,completion: @escaping ([BlogPost]) -> Void) {
        let userEmail = email
            .replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: "_")
        database
            .collection("users")
            .document(userEmail)
            .collection("posts")
            .getDocuments { snapshot, error in
                guard let document = snapshot?.documents.compactMap({$0.data()}), error == nil else {
                    print("get post error")
                    return
                }
                
                let posts:[BlogPost] = document.compactMap { dictonary in
                    guard let id = dictonary["id"] as? String,
                          let title = dictonary["title"] as? String,
                          let body = dictonary["body"] as? String,
                          let created = dictonary["created"] as? TimeInterval,
                          let imageUrlString = dictonary["headerImageUrl"] as? String else {
                              print("Invalid Post fetch conversion")
                              return nil
                          }
                    
                    let post = BlogPost(identifier: id, title: title, timestamp: created, headerImageUrl:URL(string: imageUrlString) , text: body)
                    
                    return post
                }
                completion(posts) //multiple post
        }
    }
    
    public func insert(user: User,completion: @escaping (Bool) -> Void) {
        let documentId = user.email
            .replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: "_")
        
        let data = [
            "email":user.email,
            "name":user.name
        ]
        
        database
            .collection("users")
            .document(documentId)
            .setData(data) { error in
                completion(error == nil)
            }
    }
    
    public func getUser(email:String,completion:@escaping (User?) -> Void) {
        let documentId = email
            .replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: "_")
        
        database
            .collection("users")
            .document(documentId).getDocument { snapshot, error in
                guard let data = snapshot?.data() as? [String:String],let name = data["name"] ,error == nil else {
                    print("can not found data")
                    return
                }
                
                let ref = data["profile_photo"]
                let user = User(name: name, email: email, profilePictureRef: ref)
                completion(user)
                
            }
    }
    
    func updateProrfilePhoto(email:String, completion: @escaping(Bool) -> Void) {
        let path = email
            .replacingOccurrences(of: "@", with: "_")
            .replacingOccurrences(of: ".", with: "_")
        
        let photoReference = "profile_pictures/\(path)/photo.png"
        
        let dbRef =  database
            .collection("users")
            .document(path)
        
        dbRef.getDocument { snapshot, error in
            guard var data = snapshot?.data(), error == nil else {
                return
            }
            data["profile_photo"] = photoReference
            dbRef.setData(data) { error in
                completion(error == nil)
            }
        }
    }
}
