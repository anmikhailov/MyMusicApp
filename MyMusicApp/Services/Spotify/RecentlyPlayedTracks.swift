//
//  RecentlyPlayedTracks.swift
//  MyMusicApp
//
//  Created by Kovs on 18.06.2023.
//

import Foundation

//TODO: вставить функцию ниже в VC
// также добавить в vc: var recentlyPlayedTracks: [PlayHistoryObject] = []
//TODO: чистить и заново запрашивать треки?

struct RecentlyPlayedTracksRequest: DataRequest {
    
    var limit: Int!
    
    var url: String {
        let baseUrl = Web.baseURL
        let path = "/me/player/recently-played"
        return baseUrl + path
    }
    
    var headers: [String : String] {
        [:]
    }
    
    var queryItems: [String : String] {
        [
            "limit": String(limit)
        ]
    }
    
    var method: HTTPMethod {
        .get
    }
    
    init(limit: Int) {
        self.limit = limit
    }
    
    func decode(_ data: Data) throws -> [PlayHistoryObject]? {
        let decoder = JSONDecoder()
        
        let response = try decoder.decode(RecentlyTracks.self, from: data)
        return response.items
    }
}

