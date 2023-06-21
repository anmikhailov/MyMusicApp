//
//  SpecifiedAlbum.swift
//  MyMusicApp
//
//  Created by Kovs on 18.06.2023.
//

import Foundation

/*
 curl --request GET \
 --url 'https://api.spotify.com/v1/albums/4aawyAB9vmqN3uQ7FjRGTy?market=US' \
 --header 'Authorization: Bearer BQCJhj...yTj4qc'
 */

struct SpecifiedAlbumByID: DataRequest {
    
    var id: String!
    var market: String!
    
    var url: String {
        let baseUrl = Web.baseURL
        let path = "/albums/"
        return baseUrl + path + id
    }
    
    var headers: [String : String] {
        [:]
    }
    
    var queryItems: [String : String] {
        [
            "market": market
        ]
    }
    
    var method: HTTPMethod {
        .get
    }
    
    init(market: String, id: String) {
        self.market = market
        self.id = id
    }
    
    func decode(_ data: Data) throws -> Album? {
        let decoder = JSONDecoder()
        
        let response = try decoder.decode(Album.self, from: data)
        return response
    }
}
