//
//  Album.swift
//  Cider
//
//  Created by Scott Hoyt on 8/1/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

public typealias Album = Resource<AlbumAttributes, AlbumRelationships>

public struct AlbumAttributes: Codable {
    public let artistName: String
    public let artwork: Artwork
    public let contentRating: ContentRating?
    public let copyright: String
    public let editorialNotes: EditorialNotes?
    public let genreNames: [String]
    public let isComplete: Bool
    public let isSingle: Bool
    public let name: String
    public let releaseDate: String
    public let playParams: PlayParameters?
    public let trackCount: Int
    public let url: URL
}

public struct AlbumRelationships: Codable {
    public let artists: Relationship<Artist>
    public let genres: Relationship<Genre>?
    public let tracks: Relationship<Track>
}
