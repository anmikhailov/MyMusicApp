//
//  PublicObjects.swift
//  MyMusicApp
//
//  Created by Kovs on 18.06.2023.
//

import Foundation

struct SpotifyImage: Codable {
    let url: String // Example value: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228"
    let height: Int?
    let width: Int?
}

struct SpotifyExternalUrl: Codable {
    let spotify: String
}

struct SpotifyRestrictions: Codable {
    let reason: String
    /*
     The reason for the restriction. Supported values:
     market - The content item is not available in the given market.
     product - The content item is not available for the user's subscription type.
     explicit - The content item is explicit and the user's account is set to not play explicit content.
     
     NOTE: Additional reasons may be added in the future. Note: If you use this field, make sure that your application safely handles unknown values.
     */
}

struct SpotifyCopyright: Codable {
    let text: String // The copyright text for this content.
    let type: String // The type of copyright: C = the copyright, P = the sound recording (performance) copyright.
}

struct SpotifyExternalIds: Codable {
    let isrc: String
    let ean: String
    let upc: String
}

struct SpotifySimplifiedArtist: Codable {
    let external_urls: SpotifyExternalUrl
    let href: String
    let id: String
    let name: String
    let type: String // Allowed values: "artist"
    let uri: String
}
