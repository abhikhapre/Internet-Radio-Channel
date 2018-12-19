//
//  Channel.swift
//  InternetRadioChannel
//
//  Created by Abhishek Jaykrishna Khapare on 3/29/18.
//  Copyright © 2018 AbhishekJaykrishnaKhapare. All rights reserved.
//

import Foundation


struct Channel : Decodable{
    
    let id: String?
    let title: String?
    let description: String?
    let dj: String?
    let djmail: String?
    let genre: String?
    let image: String?
    let largeimage: String?
    let xlimage: String?
    let twitter: String?
    let updated: String?
    let listeners: String?
    let lastPlaying: String?
    
    let playlists: [Playlist]?
}
