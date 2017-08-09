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
    let contentRating: ContentRating?
    let copyright: String
    let editorialNotes: EditorialNotes?
    let genreNames: [String]
    let isComplete: Bool
    let isSingle: Bool
    let name: String
    let releaseDate: String
    let playParams: PlayParameters?
    let trackCount: Int
    let url: URL
}
