//
//  AuthRespone.swift
//  Spotify
//
//  Created by sangheon on 2022/02/03.
//

import Foundation

struct AuthResponse:Codable {
    let access_token:String
    let expires_in:Int
    let refresh_token:String
    let scope:String
    let token_type:String
}


