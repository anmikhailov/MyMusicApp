//
//  StorageManager.swift
//  MyMusicApp
//
//  Created by Sergey Medvedev on 22.06.2023.
//

import Foundation
import RealmSwift

//protocol StorageManagerProtocol {
//    func save(track: SpotifySimplifiedTrack)
//    func retrieveAll() -> [SpotifySimplifiedTrack]
//    func hasObjectInStorage(with url: String) -> Bool
//    func deleteItem(by key: String)
//}

class StorageManager {
    static let shared = StorageManager()
    
    fileprivate lazy var realm = try! Realm()
    
    private init() {}
    
    func save(track: SpotifySimplifiedTrack) {
        if !hasObjectInStorage(with: track.id) {
            let track = FavoriteModel.self(track)

            try! realm.write {
                realm.add(track)
            }
        } else {
            print("Object already wrote in database")
        }
    }
    
    func retrieveAll() -> [SpotifySimplifiedTrack] {
        var bookmarkAny: [SpotifySimplifiedTrack] = []

        let bookmarks = realm.objects(FavoriteModel.self)
        for bookmark in bookmarks {
            bookmarkAny.append(SpotifySimplifiedTrack(album: nil, artists: [SpotifySimplifiedArtist(external_urls: SpotifyExternalUrl(spotify: ""), href: "", id: "", name: bookmark.nameSinger, type: "", uri: "")], duration_ms: 0, href: "", id: bookmark.id, name: bookmark.nameSong, preview_url: bookmark.previewUrl, uri: ""))
        }
        return bookmarkAny
    }
    
    func retrieveDownloaded() -> [SpotifySimplifiedTrack] {
        var bookmarkAny: [SpotifySimplifiedTrack] = []

        let bookmarks = realm.objects(FavoriteModel.self)
        for bookmark in bookmarks {
            if bookmark.localUrl != nil {
                bookmarkAny.append(SpotifySimplifiedTrack(album: nil, artists: [SpotifySimplifiedArtist(external_urls: SpotifyExternalUrl(spotify: ""), href: "", id: "", name: bookmark.nameSinger, type: "", uri: "")], duration_ms: 0, href: "", id: bookmark.id, name: bookmark.nameSong, preview_url: bookmark.localUrl, uri: ""))
            }
        }
        return bookmarkAny
    }
    
    func hasObjectInStorage(with key: String) -> Bool {
        if let _ = realm.object(ofType: FavoriteModel.self, forPrimaryKey: key) {
            return true
        } else {
            return false
        }
    }
    
    func updateitem(with key: String, value: String) {
        let object = realm.object(ofType: FavoriteModel.self, forPrimaryKey: key)
        
        realm.beginWrite()
        object?.localUrl = value
        try! realm.commitWrite()
    }
    
    func deleteItem(by key: String) {
        if let track = realm.object(ofType: FavoriteModel.self, forPrimaryKey: key) {
            try! realm.write {
                realm.delete(track)
            }
        }
    }
}

