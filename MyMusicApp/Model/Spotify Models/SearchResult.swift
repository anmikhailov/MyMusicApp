//
//  SearchResult.swift
//  MyMusicApp
//
//  Created by Andrey on 18.06.2023.
//

import Foundation

enum SearchResult {
    case artist(model: SpotifySimplifiedArtist)
    case album(model: SpotifySimplifiedAlbum)
    case track(model: SpotifySimplifiedTrack)
    case playlist(model: SpotifySimplifiedPlaylist)
}
