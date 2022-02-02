//
//  AuthManager.swift
//  Spotify
//
//  Created by sangheon on 2022/02/02.
//

import Foundation


final class AuthManager {
    static let shared = AuthManager()
    
    struct Constants {
        static let clientID = "65da0d07ff014d5c881a3d79efa97599"
        static let clientSecret = "e9ac4d2fb4d948839fb4f5aa0a18e81a"
    }
    
    private init() {}
    
    public var signInURL:URL? {
        let scopes = "user-read-private"
        let redirectURI = "https://www.iosacademy.io"
        let base = "https://accounts.spotify.com/authorize"
        let string = "\(base)?response_type=code&client_id=\(Constants.clientID)&scope=\(scopes)&redirect_uri=\(redirectURI)&show_dialog=TRUE"
        return URL(string: string)
    }
    
    var isSignedIn:Bool {
        return false
    }
    
    private var accessToken:String? {
        return nil
    }
    
    private var refreshToken:String? {
        return nil
    }
    
    private var expirationDate:Date? {
        return nil
    }
    
    private var shouldRefreshToken:Bool {
        return false
    }
    
    public func exchangeCodeForToken(code:String,completion:@escaping ((Bool) -> Void)) {
        //Get Token
    }
    
    public func refreshAccessToken() {
        
    }
    
    private func cacheToken() {
        
    }
}
