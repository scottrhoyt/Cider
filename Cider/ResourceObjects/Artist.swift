//
//  Artist.swift
//  Cider
//
//  Created by Scott Hoyt on 8/2/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

public typealias Artist = Resource<ArtistAttributes, ArtistRelationships>

public struct ArtistAttributes: Codable {
    public let genreNames: [String]
    public let editorialNotes: EditorialNotes?
    public let name: String
    public let url: URL
}

public struct ArtistRelationships: Codable {
    public let albums: Relationship<Album>
    public let genres: Relationship<Genre>?
    // public let music-videos: [Relationship<MusicVideo>?
    // public let playlists: Relationship<Playlist>?
}
