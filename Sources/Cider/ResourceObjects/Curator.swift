//
//  Curator.swift
//  Cider
//
//  Created by Scott Hoyt on 8/25/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

public typealias Curator = Resource<CuratorAttributes, CuratorRelationships>

public struct CuratorAttributes: Codable {
    public let artwork: Artwork
    public let editorialNotes: EditorialNotes?
    public let name: String
    public let url: URL
}

public struct CuratorRelationships: Codable {
    public let playlists: Relationship<Playlist>
}
