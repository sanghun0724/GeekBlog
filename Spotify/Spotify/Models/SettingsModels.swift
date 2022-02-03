//
//  SettingsModels.swift
//  Spotify
//
//  Created by sangheon on 2022/02/03.
//

import Foundation

struct Section {
    let title:String
    let options:[Option]
}

struct Option {
    let title:String
    let handler: () -> Void
}
