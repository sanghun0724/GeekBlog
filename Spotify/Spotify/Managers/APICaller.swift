//
//  APICaller.swift
//  Spotify
//
//  Created by sangheon on 2022/02/02.
//

import Foundation
final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }
    
    public func getCurrentUserProfile(completion:@escaping (Result<UserProfile,Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/me"), type: .GET) { baseRequest in
            
        }
    }
    
    //MARK: - private
    enum HTTPMethod:String {
        case GET
        case POST
    }
    
    private func createRequest(with url:URL?,type:HTTPMethod,completion:@escaping (URLRequest) -> Void) {
        AuthManager.shared.withValidToken { token in
            guard let apiURL = url else {
                return
            }
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer\(token)", forHTTPHeaderField: "Authorization")
            completion(request)
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
}
