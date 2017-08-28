//
//  MediaType.swift
//  Cider
//
//  Created by Scott Hoyt on 8/2/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

public enum MediaType: String, Codable {
    case albums
    case songs
    case artists
    case playlists
    case musicVideos = "music-videos"
    case curators
    case appleCurators = "apple-curators"
}
