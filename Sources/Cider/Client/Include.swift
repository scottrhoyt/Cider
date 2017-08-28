//
//  Include.swift
//  Cider
//
//  Created by Scott Hoyt on 8/9/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

/// Relationships to include with a lookup request.
public enum Include: String {
    case albums
    case artists
    case genres
    case tracks
}
