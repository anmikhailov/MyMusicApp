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
    let track: RPTrack
    let played_at: String
    let context: RPContext
}

struct RPTrack: Codable {
    let album: RPAlbum
    let artists: [ArtictObject]
    let available_markets: [String] // A list of the countries in which the track can be played, identified by their ISO 3166-1 alpha-2 code.
    let disc_number: Int // usually 1 unless the album consists of more than one disc
    let duration_ms: Int
    let explicit: Bool // Whether or not the track has explicit lyrics ( true = yes it does; false = no it does not OR unknown)
    let external_ids: SpotifyExternalIds
    let external_urls: SpotifyExternalUrl
    let href: String
    let id: String
    
    let is_playable: Bool // https://developer.spotify.com/documentation/web-api/concepts/track-relinking
    // If true, the track is playable in the given market. Otherwise false.
    
    let linked_from: SpotifyLinkedFrom?
    // Part of the response when Track Relinking is applied, and the requested track has been replaced with different track. The track in the linked_from object contains information about the originally requested track.
    
    let restrictions: SpotifyRestrictions
    let name: String
    let popularity: Int // from 0 to 100
    let preview_url: String? // 30 sec preview: can be nil
    let track_number: Int
    let type: String // allowed value: "track"
    let uri: String
    let is_local: Bool // Whether or not the track is from a local file.
}

struct RPAlbum: Codable {
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

struct ArtictObject: Codable {
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
