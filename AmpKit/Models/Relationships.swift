//
//  Relationships.swift
//  AmpKit
//
//  Created by Scott Hoyt on 8/4/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

struct Relationships: Codable {
    let albums: Result<MediaResult<AlbumAttributes>>?
    let artists: Result<MediaResult<ArtistAttributes>>?
    let tracks: Result<MediaResult<TrackAttributes>>?
}
