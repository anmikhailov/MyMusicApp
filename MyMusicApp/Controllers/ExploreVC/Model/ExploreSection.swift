//
//  ExploreSection.swift
//  MyMusicApp
//
//  Created by mac on 6/16/23.
//

import Foundation

enum ExploreSection {
    case recentlyMusic
    case topTrending
    case topic
    
    var title: String {
        switch self {
        case .recentlyMusic:
            return "Recently Music"
        case .topTrending:
            return "Top Trending"
        case .topic:
            return "Topic"
        }
    }
}
