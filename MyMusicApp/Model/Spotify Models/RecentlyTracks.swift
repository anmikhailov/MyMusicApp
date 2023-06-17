//
//  RecentlyTracks.swift
//  MyMusicApp
//
//  Created by Andrey on 17.06.2023.
//

import Foundation

struct RecentlyTracks: Codable {
    let next: String?
    let limit: Int
    let items: [Item]
}

struct Item: Codable {
    let track: Track
}

struct Track: Codable {
    let name: String
    let artists: [Artist]
    let album: Album
}

struct Artist: Codable {
    let name: String
}

struct Album: Codable {
    let images: [Image]
}

struct Image: Codable {
    let url: String
}
