//
//  UserPlaylists.swift
//  MyMusicApp
//
//  Created by Kovs on 22.06.2023.
//

import Foundation

struct UsersPlaylistsResponse: Codable {
    let href: String
    let limit: Int
    let next: String?
    let offset: Int
    let previous: String?
    let total: Int
    
    let items: [SimplifiedPlaylistObject]
}
