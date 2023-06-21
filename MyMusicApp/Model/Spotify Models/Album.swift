//
//  Album.swift
//  MyMusicApp
//
//  Created by Kovs on 17.06.2023.
//

import Foundation

struct Album: Codable {
//    let album_type: String // "album", "single", "compilation"
//    let total_tracks: Int
//    let available_markets: [String]
//    let external_urls: SpotifyExternalUrl
//    let href: String
//    let id: String
//    let images: SpotifyImage
    let name: String
//    let release_date: String
//    let release_date_precision: String
//    let restrictions: SpotifyRestrictions
//    let type: String
//    let uri: String
//    let copyrights: SpotifyCopyright
//    let external_ids: SpotifyExternalIds
//    let genres: [String]
//    let label: String
//    let popularity: Int
    let artists: [ArtistObject]
    let tracks: AlbumTrackObject
}

struct AlbumTrackObject: Codable {
    let href: String
    let limit: Int
    let next: String?
    let offset: Int
    let previous: String?
    let total: Int
//    let items: [SpotifySimplifiedTrackObject]
    let items: [SpotifySimplifiedTrack]
}

struct NewAlbum: Codable {
    let album_type: String // Allowed values: "album", "single", "compilation"
    let total_tracks: Int
    let available_markets: [String]
    let external_urls: SpotifyExternalUrl
    let href: String
    let id: String
    let images: [SpotifyImage]
    let name: String
    let release_date: String
    let release_date_precision: String
    let restrictions: SpotifyRestrictions?
    let type: String
    let uri: String
    let copyrights: [SpotifyCopyright]?
    let external_ids: SpotifyExternalIds?
    let genres: [String]?
    let label: String?
    let popularity: Int?
    let album_group: String?
    let artists: [SpotifySimplifiedArtist]?
}

struct AlbumsResponse: Codable {
    let albums: AlbumPage
    
    struct AlbumPage: Codable {
        let href: String // Example value: "https://api.spotify.com/v1/me/shows?offset=0&limit=20"
        let limit: Int?
        let next: String? // URL to the next page of items. ( null if none)
        // Example value: "https://api.spotify.com/v1/me/shows?offset=1&limit=1"
        let offset: Int
        let previous: String? // Example value: "https://api.spotify.com/v1/me/shows?offset=1&limit=1"
        let total: Int
        let items: [NewAlbum]
    }
}
