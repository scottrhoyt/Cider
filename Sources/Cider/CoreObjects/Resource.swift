//
//  Resource.swift
//  Cider
//
//  Created by Scott Hoyt on 8/9/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

public struct Resource<AttributesType: Codable, RelationshipsType: Codable>: Codable {
    public let id: String
    public let type: MediaType
    public let href: String
    public let attributes: AttributesType?
    public let relationships: RelationshipsType?
    // let meta: Meta
}
