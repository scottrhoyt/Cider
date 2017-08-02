//
//  Track.swift
//  AmpKit
//
//  Created by Scott Hoyt on 8/2/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

struct TrackAttributes: Codable {
    let artistName: String
    let artwork: Artwork
    let composerName: String
    let discNumber: Int
    let durationInMillis: Int
    let genreNames: [String]
    let name: String
    let playParams: PlayParams
    let releaseDate: String
    let trackNumber: Int
    let url: URL
}
