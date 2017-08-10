//
//  Relationship.swift
//  Cider
//
//  Created by Scott Hoyt on 8/9/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

public struct Relationship<T: Codable>: Codable {
    public let data: [T]?
    public let href: String
    public let next: String?
    // let meta: Meta
}

public struct VoidRelationship: Codable { }
