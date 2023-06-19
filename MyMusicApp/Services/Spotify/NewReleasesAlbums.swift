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
        [
            "Bearer AQCSq6JMkjpeZdztUFB6RVxhXk_xjqZjp3gp6OF4OGW41LbW11PVEm_zf7-1uAeqOKx0IKG4Oo0NGU_PzpZWqEHmAxqe_ftK7WKzEKDYpBmiqGXrmR_DnomjKq0Xv0p5eiXufKNO_9_7qD-uTd3rmLwb5bhrPBviJK1TYwjX2dG6sOteL7B7fStb_7yf_coGPDZ0fgvn-z1T05NPZpU_3W9CkjS9_Ns3Bt4bZ2DngAv-6MxWR1pjwc0RxuR5B77v88ytXQ8yfeVofHwZypFv73Mu8L9f7646_iGe9sU3WNTQtAZhFhIbUU7IbniNQuGJ4ngp61cLE1YS9ISn2xhAh9X5jSg6": "Authorization"
        ]
    }
    
    var queryItems: [String : String] {
        [
            "country": country,
            "offset": String(offset),
            "limit": String(limit)
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
