//
//  Genre.swift
//  Cider
//
//  Created by Scott Hoyt on 8/9/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

public typealias Genre = Resource<GenreAttributes, VoidRelationship>

public struct GenreAttributes: Codable {
    public let name: String
}
