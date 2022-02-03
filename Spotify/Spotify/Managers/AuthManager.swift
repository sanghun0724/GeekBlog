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
        static let clientID = "954973af99e44e82a2d619dbc73f585b"
        static let clientSecret = "aedbba2a96c6430c86bba00cbd5c9d69"
        static let tokenAPIURL = "https://accounts.spotify.com/api/token"
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
        return accessToken != nil
    }
    
    private var accessToken:String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    private var refreshToken:String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    
    private var tokenExpirationDate:Date? {
        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
    }
    
    private var shouldRefreshToken:Bool {
        guard let expirationDate = tokenExpirationDate else {
            return false
        }
        let currnetDate = Date()
        let fiveMinutes:TimeInterval = 300
        return currnetDate.addingTimeInterval(fiveMinutes) >= expirationDate
    }
    
    public func exchangeCodeForToken(code:String,completion:@escaping ((Bool) -> Void)) {
        //Get Token
        guard let url = URL(string: Constants.tokenAPIURL) else {
            return
        }
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: "https://www.iosacademy.io"),
        ]
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        
        let basicToken = Constants.clientID+":"+Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("Failure to get base64")
            completion(false)
            return
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self?.cacheToken(result: result)
                print("SUCCESS: \(result)")
                completion(true)
            } catch {
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
    }
    
    public func refreshAccessToken() {
        
    }
    
    private func cacheToken(result:AuthResponse) {
        UserDefaults.standard.setValue(result.access_token, forKey: "access_token")
        UserDefaults.standard.setValue(result.refresh_token, forKey: "refresh_token")
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in)), forKey: "expirationDate")
    }
}
