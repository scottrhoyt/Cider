//
//  ResponseRoot.swift
//  Cider
//
//  Created by Scott Hoyt on 8/9/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

public struct ResponseRoot<T: Codable>: Codable {
    let data: [T]?
    let results: T?
    let errors: [AppleMusicAPIError]?
    // let meta: Meta?
    let next: String?
    let href: String?
}

// Might not need this
public struct SearchResponseRoot: Codable {
    let results: SearchResults
}
