//
//  Playlist.swift
//  Cider
//
//  Created by Scott Hoyt on 8/25/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

public typealias Playlist = Resource<PlaylistAttributes, PlaylistRelationships>

public enum PlaylistType: String, Codable {
    case userShared = "user-shared"
    case editorial
    case external
    case personalMix = "personal-mix"
}

public struct PlaylistAttributes: Codable {
    public let artwork: Artwork?
    public let curatorName: String?
    public let description: EditorialNotes?
    public let lastModifiedDate: String
    public let name: String
    public let playlistType: PlaylistType
    public let playParams: PlayParameters?
    public let url: URL
}

public struct PlaylistRelationships: Codable {
    public let curator: Relationship<Curator>
    public let tracks: Relationship<Track>
}
