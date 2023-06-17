//
//  UserModel.swift
//  MyMusicApp
//
//  Created by Andrey on 12.06.2023.
//

import Foundation

struct UserProfile: Codable {
    let display_name: String
    let email: String
}

/*
 {
     country = DE;
     "display_name" = Andrey;
     email = "mands315@gmail.com";
     "explicit_content" =     {
         "filter_enabled" = 0;
         "filter_locked" = 0;
     };
     "external_urls" =     {
         spotify = "https://open.spotify.com/user/31xa5igrijpkr2qtlnqrmw3fx3rq";
     };
     followers =     {
         href = "<null>";
         total = 0;
     };
     href = "https://api.spotify.com/v1/users/31xa5igrijpkr2qtlnqrmw3fx3rq";
     id = 31xa5igrijpkr2qtlnqrmw3fx3rq;
     images =     (
     );
     product = free;
     type = user;
     uri = "spotify:user:31xa5igrijpkr2qtlnqrmw3fx3rq";
 }
 */
