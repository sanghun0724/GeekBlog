//
//  UserProfile.swift
//  Spotify
//
//  Created by sangheon on 2022/02/02.
//

import Foundation

struct UserProfile : Codable {
    let country:String
    let display_name:String
    let email:String
    let explicit_content:[String:Bool]
    let external_urls:[String:String]
//    let followers:[String:Codable?]
    let id:String
    let product:String
    let images:[UserImage]
}

struct UserImage:Codable {
    let url:String
}
