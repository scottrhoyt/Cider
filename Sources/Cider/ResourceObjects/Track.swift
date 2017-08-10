//
//  Track.swift
//  Cider
//
//  Created by Scott Hoyt on 8/2/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

public typealias Track = Resource<TrackAttributes, TrackRelationships>

public struct TrackAttributes: Codable {
    public let artistName: String
    public let artwork: Artwork
    public let composerName: String?
    public let contentRating: ContentRating?
    public let discNumber: Int
    public let durationInMillis: Int?
    public let genreNames: [String]
    public let movementCount: Int? // Classical music only
    public let movementName: String? // Classical music only
    public let movementNumber: Int? // Classical music only
    public let name: String
    public let playParams: PlayParameters?
    public let releaseDate: String
    public let trackNumber: Int
    public let url: URL
    public let workName: String? // Classical music only
}

public struct TrackRelationships: Codable {
    public let albums: Relationship<Album>
    public let artists: Relationship<Artist>
    public let genres: Relationship<Genre>?
}
