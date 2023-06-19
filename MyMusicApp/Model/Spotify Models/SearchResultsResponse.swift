//
//  SearchResults.swift
//  MyMusicApp
//
//  Created by Andrey on 18.06.2023.
//

import Foundation

struct SearchResultResponse: Codable {
    let albums: SearchAlbumsResponse
    let artists: SearchArtistsResponse
    let playlists: SearchPlaylistsResponse
    let tracks: SearchTracksResponse
}

struct SearchAlbumsResponse: Codable {
    let items: [SpotifySimplifiedAlbum]
}

struct SearchArtistsResponse: Codable {
    let items: [SpotifySimplifiedArtist]
}

struct SearchPlaylistsResponse: Codable {
    let items: [SpotifySimplifiedPlaylist]
}

struct SearchTracksResponse: Codable {
    let items: [SpotifySimplifiedTrack]
}
