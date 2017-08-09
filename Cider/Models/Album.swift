//
//  Album.swift
//  Cider
//
//  Created by Scott Hoyt on 8/1/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

public struct AlbumAttributes: Codable {
    let artistName: String
    let artwork: Artwork
    let name: String
    let playParams: PlayParams
    let copyright: String
    let genreNames: [String]
    let isComplete: Bool
    let isSingle: Bool
    let releaseDate: String
    let trackCount: Int
    let url: URL
    let editorialNotes: EditorialNotes?
}
