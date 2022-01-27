//
//  StorageManager.swift
//  Thoughts
//
//  Created by sangheon on 2022/01/26.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    static let shared = StorageManager()
    
    private let container = Storage.storage()
    
    private init() {}
    
    public func uploadUserProfilePicture(email:String,image:UIImage?,completion: @escaping (Bool) -> Void) {
        let path = email
            .replacingOccurrences(of: "@", with: "_")
            .replacingOccurrences(of: ".", with: "_")
        guard let pngData = image?.pngData() else {
            return
        }
        container
            .reference(withPath: "profile_pictures/\(path)/photo.png")
            .putData(pngData, metadata: nil) { metadata, error in
                guard metadata != nil, error == nil else {
                    print(metadata)
                    print(path)
                    print("upload data missing")
                    completion(false)
                    return
                }
                completion(true)
            }
    }
    
    public func downloadUrlForProfilePicture(user:User,completion: @escaping (URL?) -> Void) {
        
    }
    
    public func uploadBlogHeader(blogPost:BlogPost,image:UIImage?,completion: @escaping (Bool) -> Void) {
        
    }
    
    public func downloadUrlForPostHeader(blogPost:BlogPost,completion: @escaping (URL?) -> Void) {
        
    }
}
