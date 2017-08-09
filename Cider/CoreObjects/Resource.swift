//
//  Resource.swift
//  Cider
//
//  Created by Scott Hoyt on 8/9/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

public struct Resource<T: Codable>: Codable {
    let id: String
    let type: MediaType
    let href: String
    let attributes: T?
    let relationships: Relationships?
    // let meta: Meta
}
