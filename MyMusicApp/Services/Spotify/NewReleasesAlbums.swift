//
//  NewReleasesAlbums.swift
//  MyMusicApp
//
//  Created by Kovs on 18.06.2023.
//

import Foundation

//TODO: вставить функцию ниже в VC
// также добавить в vc: var newAlbums: [NewAlbum] = []

// MARK: - New releases albums
//func fetchNewReleasesAlbums() {
//    var networkService = DefaultNetworkService()
//    let request = NewReleasesAlbumRequest(country: "US", limit: 50, offset: 0)
//    networkService.request(request) { [weak self] result in
//        guard let self = self else { return }
//        switch result {
//        case .success(let albums):
//            guard let albums = albums else { return }
//            self.newAlbums = albums
//        case .failure(let error):
//            fatalError(error)
//        }
//    }
//
//}

struct NewReleasesAlbumRequest: DataRequest {
    
    var country: String!
    var limit: Int
    var offset: Int
    
    var url: String {
        let baseUrl = Web.baseURL
        let path = "/browse/new-releases"
        return baseUrl + path
    }
    
    var headers: [String : String] {
        [:]
    }
    
    var queryItems: [String : String] {
        [
            "country": country,
            "limit": String(limit),
            "offset": String(offset)
        ]
    }
    
    var method: HTTPMethod {
        .get
    }
    
    init(country: String, limit: Int, offset: Int) {
        self.country = country
        self.limit = limit
        self.offset = offset
    }
    
    func decode(_ data: Data) throws -> [NewAlbum]? {
        let decoder = JSONDecoder()
        
        let response = try decoder.decode(AlbumsResponse.self, from: data)
        return response.albums.items
    }
}
