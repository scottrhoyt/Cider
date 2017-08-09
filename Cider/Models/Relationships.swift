//
//  Relationships.swift
//  Cider
//
//  Created by Scott Hoyt on 8/4/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

public struct Relationships: Codable {
    let albums: Result<Resource<AlbumAttributes>>?
    let artists: Result<Resource<ArtistAttributes>>?
    let tracks: Result<Resource<TrackAttributes>>?
}
