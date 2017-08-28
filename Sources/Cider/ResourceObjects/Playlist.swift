//
//  Playlist.swift
//  Cider
//
//  Created by Scott Hoyt on 8/25/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

public typealias Playlist = Resource<PlaylistAttributes, PlaylistRelationships>

/// A type describing the kind of playlist
public enum PlaylistType: String, Codable {
    /// A playlist created and shared by an Apple Music user
    case userShared = "user-shared"

    /// A playlist created by an Apple Music curator
    case editorial

    /// A playlist created by an non-Apple curator or brand
    case external

    /// A personalized playlist for an Apple Music user
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
