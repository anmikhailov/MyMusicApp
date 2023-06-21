//
//  Section.swift
//  MyMusicApp
//
//  Created by mac on 6/13/23.
//

import Foundation

enum Section {
    case newSong
    case popularAlbum
    case recentlyMusic
    
    var title: String {
        switch self {
            
        case .newSong:
            return "New Songs"
        case .popularAlbum:
            return "Popular Album"
        case .recentlyMusic:
            return "Recently Music"
        }
    }
}
