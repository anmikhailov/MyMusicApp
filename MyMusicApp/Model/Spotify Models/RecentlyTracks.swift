//
//  RecentlyTracks.swift
//  MyMusicApp
//
//  Created by Andrey on 17.06.2023.
//

import Foundation

struct RecentlyTracks: Codable {
    
}
/*
 {
     cursors =     {
         after = 1687010280419;
         before = 1687010280419;
     };
     href = "https://api.spotify.com/v1/me/player/recently-played";
     items =     (
                 {
             context =             {
                 "external_urls" =                 {
                     spotify = "https://open.spotify.com/playlist/37i9dQZF1DX4jP4eebSWR9";
                 };
                 href = "https://api.spotify.com/v1/playlists/37i9dQZF1DX4jP4eebSWR9";
                 type = playlist;
                 uri = "spotify:playlist:37i9dQZF1DX4jP4eebSWR9";
             };
             "played_at" = "2023-06-17T13:58:00.419Z";
             track =             {
                 album =                 {
                     "album_type" = single;
                     artists =                     (
                                                 {
                             "external_urls" =                             {
                                 spotify = "https://open.spotify.com/artist/7tzELpzPjTq26pa5FT9ykz";
                             };
                             href = "https://api.spotify.com/v1/artists/7tzELpzPjTq26pa5FT9ykz";
                             id = 7tzELpzPjTq26pa5FT9ykz;
                             name = "Yung Yury";
                             type = artist;
                             uri = "spotify:artist:7tzELpzPjTq26pa5FT9ykz";
                         },
                                                 {
                             "external_urls" =                             {
                                 spotify = "https://open.spotify.com/artist/7oxHYIVHNg4JQdKnUe1HiQ";
                             };
                             href = "https://api.spotify.com/v1/artists/7oxHYIVHNg4JQdKnUe1HiQ";
                             id = 7oxHYIVHNg4JQdKnUe1HiQ;
                             name = "Damn Yury";
                             type = artist;
                             uri = "spotify:artist:7oxHYIVHNg4JQdKnUe1HiQ";
                         }
                     );
                     "available_markets" =                     (
                         AD,
                         AE,
                         AG,
                         AL,
                         AM,
                         AO,
                         AR,
                         AT,
                         AU,
                         AZ,
                         BA,
                         BB,
                         BD,
                         BE,
                         BF,
                         BG,
                         BH,
                         BI,
                         BJ,
                         BN,
                         BO,
                         BR,
                         BS,
                         BT,
                         BW,
                         BY,
                         BZ,
                         CA,
                         CD,
                         CG,
                         CH,
                         CI,
                         CL,
                         CM,
                         CO,
                         CR,
                         CV,
                         CW,
                         CY,
                         CZ,
                         DE,
                         DJ,
                         DK,
                         DM,
                         DO,
                         DZ,
                         EC,
                         EE,
                         EG,
                         ES,
                         ET,
                         FI,
                         FJ,
                         FM,
                         FR,
                         GA,
                         GB,
                         GD,
                         GE,
                         GH,
                         GM,
                         GN,
                         GQ,
                         GR,
                         GT,
                         GW,
                         GY,
                         HK,
                         HN,
                         HR,
                         HT,
                         HU,
                         ID,
                         IE,
                         IL,
                         IN,
                         IQ,
                         IS,
                         IT,
                         JM,
                         JO,
                         JP,
                         KE,
                         KG,
                         KH,
                         KI,
                         KM,
                         KN,
                         KR,
                         KW,
                         KZ,
                         LA,
                         LB,
                         LC,
                         LI,
                         LK,
                         LR,
                         LS,
                         LT,
                         LU,
                         LV,
                         LY,
                         MA,
                         MC,
                         MD,
                         ME,
                         MG,
                         MH,
                         MK,
                         ML,
                         MN,
                         MO,
                         MR,
                         MT,
                         MU,
                         MV,
                         MW,
                         MX,
                         MY,
                         MZ,
                         NA,
                         NE,
                         NG,
                         NI,
                         NL,
                         NO,
                         NP,
                         NR,
                         NZ,
                         OM,
                         PA,
                         PE,
                         PG,
                         PH,
                         PK,
                         PL,
                         PS,
                         PT,
                         PW,
                         PY,
                         QA,
                         RO,
                         RS,
                         RW,
                         SA,
                         SB,
                         SC,
                         SE,
                         SG,
                         SI,
                         SK,
                         SL,
                         SM,
                         SN,
                         SR,
                         ST,
                         SV,
                         SZ,
                         TD,
                         TG,
                         TH,
                         TJ,
                         TL,
                         TN,
                         TO,
                         TR,
                         TT,
                         TV,
                         TW,
                         TZ,
                         UA,
                         UG,
                         US,
                         UY,
                         UZ,
                         VC,
                         VE,
                         VN,
                         VU,
                         WS,
                         XK,
                         ZA,
                         ZM,
                         ZW
                     );
                     "external_urls" =                     {
                         spotify = "https://open.spotify.com/album/6RfzTgu36z9KsBvxPKoMom";
                     };
                     href = "https://api.spotify.com/v1/albums/6RfzTgu36z9KsBvxPKoMom";
                     id = 6RfzTgu36z9KsBvxPKoMom;
                     images =                     (
                                                 {
                             height = 640;
                             url = "https://i.scdn.co/image/ab67616d0000b273914677a4057e98b10548a29f";
                             width = 640;
                         },
                                                 {
                             height = 300;
                             url = "https://i.scdn.co/image/ab67616d00001e02914677a4057e98b10548a29f";
                             width = 300;
                         },
                                                 {
                             height = 64;
                             url = "https://i.scdn.co/image/ab67616d00004851914677a4057e98b10548a29f";
                             width = 64;
                         }
                     );
                     name = "TABU.";
                     "release_date" = "2023-03-17";
                     "release_date_precision" = day;
                     "total_tracks" = 1;
                     type = album;
                     uri = "spotify:album:6RfzTgu36z9KsBvxPKoMom";
                 };
                 artists =                 (
                                         {
                         "external_urls" =                         {
                             spotify = "https://open.spotify.com/artist/7tzELpzPjTq26pa5FT9ykz";
                         };
                         href = "https://api.spotify.com/v1/artists/7tzELpzPjTq26pa5FT9ykz";
                         id = 7tzELpzPjTq26pa5FT9ykz;
                         name = "Yung Yury";
                         type = artist;
                         uri = "spotify:artist:7tzELpzPjTq26pa5FT9ykz";
                     },
                                         {
                         "external_urls" =                         {
                             spotify = "https://open.spotify.com/artist/7oxHYIVHNg4JQdKnUe1HiQ";
                         };
                         href = "https://api.spotify.com/v1/artists/7oxHYIVHNg4JQdKnUe1HiQ";
                         id = 7oxHYIVHNg4JQdKnUe1HiQ;
                         name = "Damn Yury";
                         type = artist;
                         uri = "spotify:artist:7oxHYIVHNg4JQdKnUe1HiQ";
                     }
                 );
                 "available_markets" =                 (
                     AR,
                     AU,
                     AT,
                     BE,
                     BO,
                     BR,
                     BG,
                     CA,
                     CL,
                     CO,
                     CR,
                     CY,
                     CZ,
                     DK,
                     DO,
                     DE,
                     EC,
                     EE,
                     SV,
                     FI,
                     FR,
                     GR,
                     GT,
                     HN,
                     HK,
                     HU,
                     IS,
                     IE,
                     IT,
                     LV,
                     LT,
                     LU,
                     MY,
                     MT,
                     MX,
                     NL,
                     NZ,
                     NI,
                     NO,
                     PA,
                     PY,
                     PE,
                     PH,
                     PL,
                     PT,
                     SG,
                     SK,
                     ES,
                     SE,
                     CH,
                     TW,
                     TR,
                     UY,
                     US,
                     GB,
                     AD,
                     LI,
                     MC,
                     ID,
                     JP,
                     TH,
                     VN,
                     RO,
                     IL,
                     ZA,
                     SA,
                     AE,
                     BH,
                     QA,
                     OM,
                     KW,
                     EG,
                     MA,
                     DZ,
                     TN,
                     LB,
                     JO,
                     PS,
                     IN,
                     BY,
                     KZ,
                     MD,
                     UA,
                     AL,
                     BA,
                     HR,
                     ME,
                     MK,
                     RS,
                     SI,
                     KR,
                     BD,
                     PK,
                     LK,
                     GH,
                     KE,
                     NG,
                     TZ,
                     UG,
                     AG,
                     AM,
                     BS,
                     BB,
                     BZ,
                     BT,
                     BW,
                     BF,
                     CV,
                     CW,
                     DM,
                     FJ,
                     GM,
                     GE,
                     GD,
                     GW,
                     GY,
                     HT,
                     JM,
                     KI,
                     LS,
                     LR,
                     MW,
                     MV,
                     ML,
                     MH,
                     FM,
                     NA,
                     NR,
                     NE,
                     PW,
                     PG,
                     WS,
                     SM,
                     ST,
                     SN,
                     SC,
                     SL,
                     SB,
                     KN,
                     LC,
                     VC,
                     SR,
                     TL,
                     TO,
                     TT,
                     TV,
                     VU,
                     AZ,
                     BN,
                     BI,
                     KH,
                     CM,
                     TD,
                     KM,
                     GQ,
                     SZ,
                     GA,
                     GN,
                     KG,
                     LA,
                     MO,
                     MR,
                     MN,
                     NP,
                     RW,
                     TG,
                     UZ,
                     ZW,
                     BJ,
                     MG,
                     MU,
                     MZ,
                     AO,
                     CI,
                     DJ,
                     ZM,
                     CD,
                     CG,
                     IQ,
                     LY,
                     TJ,
                     VE,
                     ET,
                     XK
                 );
                 "disc_number" = 1;
                 "duration_ms" = 135302;
                 explicit = 0;
                 "external_ids" =                 {
                     isrc = QZES82389788;
                 };
                 "external_urls" =                 {
                     spotify = "https://open.spotify.com/track/42Ztw2ZtZR3mtWjXpg0R5I";
                 };
                 href = "https://api.spotify.com/v1/tracks/42Ztw2ZtZR3mtWjXpg0R5I";
                 id = 42Ztw2ZtZR3mtWjXpg0R5I;
                 "is_local" = 0;
                 name = "TABU.";
                 popularity = 84;
                 "preview_url" = "https://p.scdn.co/mp3-preview/f9fb3d998c6d0b7c889b563cdc6c0206a3765c70?cid=bf130a2999604796a93c9fca3f16cc1f";
                 "track_number" = 1;
                 type = track;
                 uri = "spotify:track:42Ztw2ZtZR3mtWjXpg0R5I";
             };
         }
     );
     limit = 20;
     next = "https://api.spotify.com/v1/me/player/recently-played?before=1687010280419";
 }
 
 */
