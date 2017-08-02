//
//  Album.swift
//  AmpKit
//
//  Created by Scott Hoyt on 8/1/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

struct AlbumAttributes: Codable {
    let artistName: String
    let artwork: AlbumArtwork
    let name: String
    let playParams: PlayParams
    let copyright: String
    let genreNames: [String]
    let isComplete: Bool
    let isSingle: Bool
    let releaseDate: String
    let trackCount: Int
    let url: URL
}

struct AlbumArtwork: Codable {
    let bgColor: String
    let height: Int
    let width: Int
    let url: String

    // These might not be optionals
    let textColor1: String?
    let textColor2: String?
    let textColor3: String?
    let textColor4: String?
}
