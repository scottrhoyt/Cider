//
//  ContentRating.swift
//  Cider
//
//  Created by Scott Hoyt on 8/9/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

/// A type indicating the content rating of a resource
public enum ContentRating: String, Codable {
    /// The resource is rated as not containing explicit content
    case clean

    /// The resource is rated as containing explicit content
    case explicit
}
