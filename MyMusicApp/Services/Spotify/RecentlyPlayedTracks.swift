//
//  RecentlyPlayedTracks.swift
//  MyMusicApp
//
//  Created by Kovs on 18.06.2023.
//

import Foundation

//TODO: вставить функцию ниже в VC
// также добавить в vc: var recentlyPlayedTracks: [PlayHistoryObject] = []

//func fetchRecentlyPlayedTracks() {
//    var networkService = DefaultNetworkService()
//    let request = RecentlyPlayedTracksRequest(limit: 5)
//    networkService.request(request) { [weak self] result in
//        guard let self = self else { return }
//        switch result {
//        case .success(let tracks):
//            guard let tracks = tracks else { return }
//            self.recentlyPlayedTracks.removeAll()
//            self.recentlyPlayedTracks = tracks
//        case .failure(let error):
//            fatalError(error)
//        }
//    }
//}

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

