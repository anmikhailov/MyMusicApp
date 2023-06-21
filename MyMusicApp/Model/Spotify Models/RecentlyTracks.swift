//
//  RecentlyTracks.swift
//  MyMusicApp
//
//  Created by Andrey on 17.06.2023.
//

import Foundation

/*
 curl --request GET \
   --url https://api.spotify.com/v1/me/player/recently-played \
   --header 'Authorization: Bearer undefined...undefined'
 */

struct RecentlyTracks: Codable {
    let href: String
    let limit: Int
    let next: String
    let cursors: Cursors
    let total: Int
    let items: [PlayHistoryObject]
}

struct Cursors: Codable {
    let after: String
    let before: String
}

struct PlayHistoryObject: Codable {
    let track: Track
    let played_at: String
    let context: RPContext
}

struct RPAlbum: Codable, Hashable {
    let album_type: String // "album", "single", "compilation"
    let total_tracks: Int
    let available_markets: [String]
    let external_urls: SpotifyExternalUrl
    let href: String
    let id: String // Example value: "2up3OPMp9Tb4dAKM2erWXQ"
    let images: [SpotifyImage]
    let name: String
    
    let release_date: String //TODO: Example value: "1981-12"
    
    let release_date_precision: String // Allowed values: "year", "month", "day"
    
    let restrictions: SpotifyRestrictions // "market", "product", "explicit"
    
    let type: String // Allowed values: "album"
    let uri: String // Example value: "spotify:album:2up3OPMp9Tb4dAKM2erWXQ"
    let copyrights: [SpotifyCopyright]
    let external_ids: SpotifyExternalIds
    let genres: [String]
    let label: String
    let popularity: Int // from 0 to 100
    
    // ---
    let album_group: String?
    // The field is present when getting an artist's albums. Compare to album_type this field represents relationship between the artist and the album.
    // Example value: "compilation"
    // Allowed values: "album", "single", "compilation", "appears_on"
    // ---
    
    let artists: [SpotifySimplifiedArtist]
}

struct ArtistObject: Codable, Hashable {
//    let external_urls: SpotifyExternalUrl
//    let followers: Followers?
//    let genres: [String]? // If not yet classified, the array is empty.
    let href: String
//    let id: String
//    let images: [SpotifyImage]
    let name: String
//    let popularity: Int
//    let type: String // Allowed values: "artist"
    let uri: String
}

struct RPContext: Codable {
    let href: String
    let type: String
    let uri: String
    let external_urls: SpotifyExternalUrl
}

struct Followers: Codable {
    let href: String? // This will always be set to null, as the Web API does not support it at the moment.
    let total: Int?
}
