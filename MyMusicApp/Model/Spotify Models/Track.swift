//
//  Track.swift
//  MyMusicApp
//
//  Created by Kovs on 20.06.2023.
//

import Foundation

struct Track: Codable, Hashable {
    let album: RPAlbum
    let artists: [ArtistObject]
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
