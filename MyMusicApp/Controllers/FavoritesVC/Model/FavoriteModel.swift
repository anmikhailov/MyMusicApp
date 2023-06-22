//
//  FavoriteModel.swift
//  MyMusicApp
//
//  Created by Sergey Medvedev on 22.06.2023.
//

import Foundation
import RealmSwift
import UIKit

class FavoriteModel: Object {
    @Persisted var nameSinger: String
    @Persisted var nameSong: String
//    @Persisted var image: Data
    @Persisted var id: String
    @Persisted var previewUrl: String
    @Persisted var localUrl: String?
    
    convenience init(_ track: SpotifySimplifiedTrack) {
        self.init()
        
        self.nameSinger = track.artists.first?.name ?? ""
        self.nameSong = track.name
        self.id = track.id
        self.previewUrl = track.preview_url ?? ""
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
