//
//  Section.swift
//  MyMusicApp
//
//  Created by mac on 6/13/23.
//

import Foundation

struct Section {
    let title: String
    let items: [String]
    let style: SectionStyle
}

enum SectionStyle {
    case newSong
    case popularAlbum
    case recentlyMusic
}
