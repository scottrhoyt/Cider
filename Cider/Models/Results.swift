//
//  Results.swift
//  Cider
//
//  Created by Scott Hoyt on 8/1/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

// Might not need this
public struct SearchResults: Codable {
    let results: Results
}

public struct Results: Codable {
    let albums: Result<Resource<AlbumAttributes>>?
    let artists: Result<Resource<ArtistAttributes>>?
    let songs: Result<Resource<TrackAttributes>>?
}

public struct Result<T: Codable>: Codable {
    let data: [T]

    let href: String?
    let next: String?
}
