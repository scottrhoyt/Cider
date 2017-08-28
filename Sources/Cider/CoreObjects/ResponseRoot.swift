//
//  ResponseRoot.swift
//  Cider
//
//  Created by Scott Hoyt on 8/9/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

public struct ResponseRoot<T: Codable>: Codable {
    public let data: [T]?
    public let results: T?
    public let errors: [AppleMusicAPIError]?
    // let meta: Meta?
    public let next: String?
    public let href: String?
}
