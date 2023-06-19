//
//  ExploreSection.swift
//  MyMusicApp
//
//  Created by mac on 6/16/23.
//

import Foundation

struct ExploreSection {
    let title: String
    let items: [String]
    let style: ExploreStyle
}

enum ExploreStyle {
    case recentlyMusic
    case topTrending
    case topic
}
