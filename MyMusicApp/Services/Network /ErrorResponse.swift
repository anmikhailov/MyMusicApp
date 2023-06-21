//
//  ErrorResponse.swift
//  MyMusicApp
//
//  Created by Kovs on 18.06.2023.
//

import Foundation

enum ErrorResponse: String {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    
    public var description: String {
        switch self {
        case .apiError: return "Ooops, there is something wrong with the api"
        case .invalidEndpoint: return "Ooops, there is something wrong with the endpoint"
        case .invalidResponse: return "Ooops, there is something wrong with the response"
        case .noData: return "Ooops, there is something wrong with the data"
        case .serializationError: return "Ooops, there is something wrong with the serialization process"
        }
    }
}

enum FavoriteError: String, Error {
    case unableToFavorite = "There was an error favoriting this track. Please try again"
    case alreadyFavorited = "You've already favorited this track!"
}
