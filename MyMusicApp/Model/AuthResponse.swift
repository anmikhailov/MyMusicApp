//
//  AuthResponse.swift
//  MyMusicApp
//
//  Created by Kovs on 14.06.2023.
//

import Foundation

struct AuthResponse: Codable {
    let access_token: String
    let token_type: String
    let expires_in: Int
    let refresh_token: String?
    let scope: String
}
