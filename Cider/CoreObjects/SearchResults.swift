//
//  SearchResults.swift
//  Cider
//
//  Created by Scott Hoyt on 8/1/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

public struct SearchResults: Codable {
    public let albums: ResponseRoot<Album>?
    public let artists: ResponseRoot<Artist>?
    public let songs: ResponseRoot<Track>?
}
