//
//  PublicObjects.swift
//  MyMusicApp
//
//  Created by Kovs on 18.06.2023.
//

import Foundation

struct SpotifyImage: Codable {
    let url: String // Example value: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228"
    let height: Int?
    let width: Int?
}

struct SpotifyExternalUrl: Codable {
    let spotify: String
}

struct SpotifyRestrictions: Codable {
    let reason: String
    /*
     The reason for the restriction. Supported values:
     market - The content item is not available in the given market.
     product - The content item is not available for the user's subscription type.
     explicit - The content item is explicit and the user's account is set to not play explicit content.
     
     NOTE: Additional reasons may be added in the future. Note: If you use this field, make sure that your application safely handles unknown values.
     */
}

struct SpotifyCopyright: Codable {
    let text: String // The copyright text for this content.
    let type: String // The type of copyright: C = the copyright, P = the sound recording (performance) copyright.
}

struct SpotifyLinkedFrom: Codable {
    let external_urls: SpotifyExternalUrl
    let href: String
    let id: String
    let type: String // allowed: "track"
    let uri: String
}

struct SpotifyExternalIds: Codable {
    let isrc: String
    let ean: String
    let upc: String
}

struct SpotifySimplifiedArtist: Codable {
    let external_urls: SpotifyExternalUrl
    let href: String
    let id: String
    let name: String
    let type: String // Allowed values: "artist"
    let uri: String
}

struct SpotifySimplifiedAlbum: Codable {
    let album_type: String
    let total_tracks: Int
    let available_markets: [String]
    let external_urls: SpotifyExternalUrl
    let href: String
    let id: String
    let images: [SpotifyImage]
    let name: String
    let release_date: String
    let release_date_precision: String
    let type: String
    let uri: String
    let artists: [SpotifySimplifiedArtist]
}

struct SpotifySimplifiedPlaylist: Codable {
    let description: String
    let external_urls: SpotifyExternalUrl
    let href: String
    let id: String
    let images: [SpotifyImage]
    let name: String
    let tracks: SpotifyTracksInPlaylist
    let type: String
    let uri: String
}

struct SpotifyTracksInPlaylist: Codable {
    let href: String
    let total: Int
}

struct SpotifySimplifiedTrack: Codable {
    let album: SpotifySimplifiedAlbum
    let artists: [SpotifySimplifiedArtist]
    let available_markets: [String]
    let disc_number: Int
    let duration_ms: Int
    let explicit: Bool
    let external_urls: SpotifyExternalUrl
    let href: String
    let id: String
    let name: String
    let popularity: Int // from 0 to 100
    let preview_url: String? // 30 sec preview: can be nil
    let track_number: Int
    let type: String // allowed value: "track"
    let uri: String
    let is_local: Bool // Whether or not the track is from a local file.
}

struct SpotifyTrack: Codable {
    let href: String
    let limit: Int
    let next: String?
    let offset: Int // default 0
    let previous: String? // Example value: "https://api.spotify.com/v1/me/shows?offset=1&limit=1"
    let total: Int
    let items: [SpotifySimplifiedTrackObject]
}

struct SpotifySimplifiedTrackObject: Codable {
    let artists: [SpotifySimplifiedArtist]
//    let available_markets: [String]
//    let disc_number: Int
//    let explicit: Bool
    let duration_ms: Int
    let href: String
    let id: String
//    let is_playable: Bool
//    let linked_from: SpotifyLinkedFrom?
//    let restrictions: SpotifyRestrictions?
    let name: String
    let preview_url: String?
//    let track_number: Int
//    let type: String // "track"
    let uri: String
//    let is_local: Bool
}
