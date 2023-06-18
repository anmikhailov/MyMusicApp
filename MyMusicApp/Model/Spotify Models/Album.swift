//
//  Album.swift
//  MyMusicApp
//
//  Created by Kovs on 17.06.2023.
//

import Foundation

struct Album: Codable {
    let albumType: String?
    let total_tracks: Int?
    let available_markets: [String]?
    let external_urls: [String: String]?
    let href: String?
    let id: String?
    let images: [[String: Any]]?
    let name: String?
    let release_date: String?
    let release_date_precision: String?
    let restrictions: [String: String]?
    let type: String?
    let uri: String?
    let copyrights: [[String: String]]?
    let external_ids: [String: String]?
    let genres: [String]?
    let label: String?
    let popularity: Int?
    let artists: [[String: Any]]?
    let tracks: [String: Any]?
}
