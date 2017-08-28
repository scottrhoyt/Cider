//
//  MusicVideo.swift
//  Cider
//
//  Created by Scott Hoyt on 8/25/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

public typealias MusicVideo = Resource<MusicVideoAttributes, MusicVideoRelationships>

public struct MusicVideoAttributes: Codable {
    public let artistName: String
    public let artwork: Artwork
    public let contentRating: ContentRating?
    public let durationInMillis: Int?
    public let editorialNotes: EditorialNotes?
    public let genreNames: [String]
    public let name: String
    public let playParams: PlayParameters?
    public let releaseDate: String
    public let trackNumber: Int?
    public let url: URL
    public let videoSubType: String?
}

public struct MusicVideoRelationships: Codable {
    public let albums: Relationship<Album>
    public let artists: Relationship<Artist>
    public let genres: Relationship<Genre>?
}
